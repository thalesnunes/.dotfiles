vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		separator_style = { "", "" },
		show_close_icon = false,
		show_buffer_close_icons = false,
		tab_size = 15,
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
		custom_filter = function(buf_number, _)
			if vim.fn.bufname(buf_number) ~= "[No Name]" then
				return true
			end
		end,
		offsets = {
			{
				filetype = "undotree",
				text = "Undotree",
				highlight = "PanelHeading",
			},
		},
	},
})

V.keymap("n", "<leader>l", ":BufferLineCycleNext<CR>")
V.keymap("n", "<leader>h", ":BufferLineCyclePrev<CR>")
V.keymap("n", "<leader>>", ":BufferLineMoveNext<CR>")
V.keymap("n", "<leader><", ":BufferLineMovePrev<CR>")
