vim.pack.add({
	"https://github.com/AckslD/nvim-neoclip.lua",
	"https://github.com/nvim-telescope/telescope.nvim",
})

require("neoclip").setup()
V.keymap("n", "<leader>v", ':lua require("telescope").extensions.neoclip.default()<CR>')
V.keymap("v", "<leader>v", ':lua require("telescope").extensions.neoclip.default()<CR>')
