return {
	"kevinhwang91/rnvimr",
    event = "VeryLazy",
	config = function()
		-- Make Ranger replace Netrw and be the file explorer
		vim.g.rnvimr_enable_ex = 1

		-- Make Ranger to be hidden after picking a file
		vim.g.rnvimr_enable_picker = 1

		-- Replace `$EDITOR` candidate with this command to open the selected file
		vim.g.rnvimr_edit_cmd = "drop"

		-- Disable a border for floating window
		vim.g.rnvimr_draw_border = 1

		-- Hide the files included in gitignore
		vim.g.rnvimr_hide_gitignore = 0

		-- Change the border's color
		-- vim.g.rnvimr_border_attr = {'fg' = 14, 'bg' = -1}

		-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
		vim.g.rnvimr_enable_bw = 1

		-- Add a shadow window, value is equal to 100 will disable shadow
		vim.g.rnvimr_shadow_winblend = 100

		-- Draw border with both
		-- vim.g.rnvimr_ranger_cmd = {'ranger', '--cmd=set draw_borders both'}

		-- Map Rnvimr action
		vim.g.rnvimr_action = false

		-- Fullscreen for initial layout
		vim.g.rnvimr_layout = {
			relative = "editor",
			width = vim.o.columns,
			height = math.floor(0.9 * vim.o.lines),
			col = 0,
			row = 1,
			style = "minimal",
		}

		-- Link CursorLine into RnvimrNormal highlight in the Floating window
		vim.cmd("highlight link RnvimrNormal CursorLine")

		V.keymap("n", "<leader>e", ":RnvimrToggle<CR>")

		vim.api.nvim_create_autocmd("Filetype", {
			group = vim.api.nvim_create_augroup("ranger", { clear = true }),
			pattern = "rnvimr",
			callback = function()
				V.buf_keymap(0, "t", "<ESC>", "<ESC>", { nowait = true })
			end,
		})

		-- Run Rnvimr on startup when opened object is directory or [No name]
		-- Else open ranger as background process
		vim.defer_fn(function()
			local curr_path = vim.fn.expand("%:p")
			if vim.fn.isdirectory(curr_path) == 1 or curr_path == "" then
				vim.cmd("RnvimrToggle")
			else
				vim.cmd("RnvimrStartBackground")
			end
		end, 0)
	end,
}
