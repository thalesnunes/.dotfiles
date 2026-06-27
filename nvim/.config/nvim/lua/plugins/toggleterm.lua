vim.pack.add({
	"https://github.com/akinsho/toggleterm.nvim",
})

require("toggleterm").setup({
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = false,
	terminal_mappings = false,
	persist_size = false,
	direction = "float",
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	hidden = true,
	float_opts = {
		width = vim.o.columns - 10,
		height = vim.o.lines - 6,
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		V.buf_keymap(term.bufnr, "n", "q", ":close<CR>")
		V.buf_keymap(term.bufnr, "t", "<Esc>", "<Esc>")
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end
