return {
	"akinsho/toggleterm.nvim",
	keys = {
		"<leader>t",
		-- '<leader>g',
	},
	opts = {
		-- size can be a number or function which is passed the current terminal
		open_mapping = [[<leader>t]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		start_in_insert = true,
		insert_mappings = false,
		terminal_mappings = false,
		persist_size = false,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			hidden = true,
			float_opts = {
				width = vim.o.columns - 10,
				height = vim.o.lines - 6,
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				V.buf_keymap(term.bufnr, "n", "q", ":close<CR>")
				V.buf_keymap(term.bufnr, "t", "<Esc>", "<Esc>")
			end,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		-- ToggleTerm lazygit
		-- V.keymap('n', '<leader>g', ':lua _lazygit_toggle()<CR>')
	end,
}
