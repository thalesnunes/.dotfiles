local M = {}

-- Configuration (will be set by setup function)
local config = {}

Infile = nil
Outfile = nil

-- Select a command to use
function M.select_command(callback)
	if vim.tbl_isempty(config.commands) then
		vim.notify("[sql-runner] No commands configured. Add commands to your config file.", vim.log.levels.WARN)
		return
	end

	local items = {}
	for alias, cmd in pairs(config.commands) do
		table.insert(items, {
			alias = alias,
			cmd = cmd,
		})
	end

	-- Sort items by alias for consistent ordering
	table.sort(items, function(a, b)
		return a.alias < b.alias
	end)

	local current_alias = M.selected_command_alias
	local prompt = callback and "Select SQL command to run:" or "Select SQL command:"

	vim.ui.select(items, {
		prompt = prompt,
		format_item = function(item)
			local marker = (item.alias == current_alias) and " [current]" or ""
			return item.alias .. marker
		end,
	}, function(choice)
		if choice then
			M.selected_command_alias = choice.alias
			if callback then
				callback(choice.alias, choice.cmd)
			else
				vim.notify(string.format('[sql-runner] Selected "%s"', choice.alias), vim.log.levels.INFO)
			end
		end
	end)
end

-- Find an existing window showing the given absolute path
local function find_win_by_path(abs_path)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if name == abs_path then
			return win
		end
	end
	return nil
end

-- Get SQL statement under cursor (between semicolons or file boundaries)
local function get_sql_statement_at_cursor()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1]
	local col = cursor_pos[2]
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	if #lines == 0 then
		return ""
	end

	-- Find start: search backward for semicolon or use beginning of file
	local start_line = 1
	local start_col = 1

	for i = row, 1, -1 do
		local line = lines[i] or ""
		local search_line = (i == row) and line:sub(1, col) or line
		local semicolon_pos = search_line:find(";[^;]*$")
		if semicolon_pos then
			start_line = i
			start_col = semicolon_pos + 1
			break
		end
	end

	-- Find end: search forward for semicolon or use end of file
	local end_line = #lines
	local end_col = #(lines[#lines] or "")

	for i = row, #lines do
		local line = lines[i] or ""
		local search_line = (i == row) and line:sub(col + 1) or line
		local semicolon_pos = search_line:find(";")
		if semicolon_pos then
			end_line = i
			end_col = (i == row) and (col + semicolon_pos - 1) or semicolon_pos - 1
			break
		end
	end

	-- Extract lines
	local result_lines = {}
	for i = start_line, end_line do
		local line = lines[i] or ""
		if i == start_line and i == end_line then
			table.insert(result_lines, line:sub(start_col, end_col))
		elseif i == start_line then
			table.insert(result_lines, line:sub(start_col))
		elseif i == end_line then
			table.insert(result_lines, line:sub(1, end_col))
		else
			table.insert(result_lines, line)
		end
	end

	return table.concat(result_lines, "\n"):match("^%s*(.-)%s*$") or ""
end

-- Get visual text selected
local function get_text_from_visual_selection()
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)
	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")
	return table.concat(vim.fn.getregion(vstart, vend), "\n")
end

-- Common function to run queries with any backend
local function run_query(name, cmd, query_text)
	vim.api.nvim_echo({ { "[sql-runner] Running " .. name .. " query…", "ModeMsg" } }, false, {})

	-- Step 1: Always store the query in a temp file first
	local current_timestamp = os.date("%s")
	Infile = "/tmp/sql_" .. current_timestamp .. ".in"
	Outfile = "/tmp/sql_" .. current_timestamp .. ".out"
	if not query_text or query_text == "" then
		vim.api.nvim_echo({ { "[sql-runner] No SQL statement found", "ErrorMsg" } }, false, {})
		return
	end
	local file = io.open(Infile, "w")
	if file then
		file:write(query_text)
		file:close()
	else
		vim.api.nvim_echo({ { "[sql-runner] Failed to create temporary file", "ErrorMsg" } }, false, {})
		return
	end

	-- Run in tmux window with less, non-blocking
	local full_cmd = string.format(cmd .. " &", Infile, Outfile)
	io.popen(full_cmd)
	vim.api.nvim_echo(
		{ { "[sql-runner] " .. name .. " query running in tmux window 'sql-run'", "ModeMsg" } },
		false,
		{}
	)

	-- Step 2: Run the command
	if config.use_tmux_window and vim.env.TMUX then
		local file_handle = assert(io.popen("tmux display-message -p '#{session_name}'"))
		local tmux_current_session = assert(file_handle:read("*l"))
		file_handle:close()
		local socket_filename = "/tmp/nvim_" .. tmux_current_session .. ".sock"
		if vim.fn.filereadable(socket_filename) == 0 then
			local nvim_sql_cmd = string.format("tmux neww -d -nsql nvim --listen " .. socket_filename)
			vim.cmd("silent !" .. nvim_sql_cmd)
		end

		M.view_output_file(Outfile, socket_filename)
	else
		-- Show results in nvim split
		local win = find_win_by_path(Outfile)
		if win then
			vim.api.nvim_set_current_win(win)
			vim.cmd("noautocmd edit")
		else
			vim.cmd("split " .. vim.fn.fnameescape(Outfile))
		end
	end

	local ms = math.floor((os.date("%s") - current_timestamp) / 1e6)
	vim.api.nvim_echo({ { string.format("[sql-runner] %s query done in %d ms", name, ms), "ModeMsg" } }, false, {})
end

-- View SQL query output in tmux window
function M.view_output_file(filename, socket_filename)
	local outfile = filename == {} and Outfile or filename

	if not filename and vim.fn.filereadable(outfile) == 0 then
		vim.notify("[sql-runner] No previous query output found", vim.log.levels.WARN)
		return false
	end

	if not vim.env.TMUX then
		vim.notify("[sql-runner] Not running in tmux session", vim.log.levels.WARN)
		return false
	end

	io.popen(
		string.format(
			'bash -c "until [ -f \\"%s\\" ]; do sleep 1; done; nvim --server %s --remote %s" &',
			filename,
			socket_filename,
			filename
		)
	)

	vim.notify("[sql-runner] Opened query output in tmux window", vim.log.levels.INFO)
	return true
end

-- Run SQL with the selected command
function M.run_sql(opts)
	-- Get query_text
	local query_text = opts.range == 2 and get_text_from_visual_selection() or get_sql_statement_at_cursor()

	local function execute_with_command(alias, cmd)
		run_query(alias, cmd, query_text)
	end

	if not M.selected_command_alias then
		M.select_command(execute_with_command)
	else
		local cmd = config.commands[M.selected_command_alias]
		if cmd then
			execute_with_command(M.selected_command_alias, cmd)
		else
			vim.notify("[sql-runner] Selected command not found", vim.log.levels.ERROR)
		end
	end
end

-- Setup function to initialize with config
function M.setup(user_config)
	user_config = user_config or {}

	-- Default configuration
	local default_config = {
		commands = {},
		default_command = nil,
		use_tmux_window = true,
	}

	-- Merge user config with defaults (user config takes precedence)
	local merged_config = vim.tbl_deep_extend("force", default_config, user_config)

	-- Store merged config in module-level config variable
	config = merged_config

	M.selected_command_alias = config.default_command
end

-- Initialize with defaults if no setup called
M.setup()

-- Register commands
vim.api.nvim_create_user_command("SelectSqlCmd", M.select_command, { desc = "Select a SQL command to use." })
vim.api.nvim_create_user_command("ViewSqlOutput", M.view_output_file, { desc = "View the last SQL query output." })
vim.api.nvim_create_user_command(
	"RunSQL",
	M.run_sql,
	{ desc = "Run SQL selected query or query under cursor.", range = true }
)

return M
