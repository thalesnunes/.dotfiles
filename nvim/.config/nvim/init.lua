V = require("helpers")

require("settings")

-- Load all files under the lua/plugins dir automatically
local function require_plugins(dir, prefix)
	local handle = vim.uv.fs_scandir(dir)
	if not handle then
		return
	end

	while true do
		local name, type = vim.uv.fs_scandir_next(handle)
		if not name then
			break
		end

		local path = dir .. "/" .. name

		if type == "directory" then
			require_plugins(path, prefix .. "." .. name)
		elseif type == "file" and name:match("%.lua$") then
			local module = prefix .. "." .. name:gsub("%.lua$", "")
			require(module)
		end
	end
end

local config = vim.fn.stdpath("config")
require_plugins(config .. "/lua/plugins", "plugins")

-- Local plugins loaded manually
require("tools.sql-runner").setup({
	commands = {
		snowflake = "snowsql --noup --abort-detached-query -o friendly=false -o quiet=true -f %s -o output_file=%s",
	},
	default_command = "snowflake",
	use_tmux_window = true,
})

require("keymaps")
