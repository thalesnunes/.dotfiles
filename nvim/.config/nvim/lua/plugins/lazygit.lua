vim.pack.add({
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
})

V.keymap("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
