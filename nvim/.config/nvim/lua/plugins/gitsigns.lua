vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

require("gitsigns").setup({
	signcolumn = true,
	attach_to_untracked = true,
	max_file_length = 40000,
})
