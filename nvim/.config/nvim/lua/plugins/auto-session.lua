vim.pack.add({
	"https://github.com/rmagatti/auto-session",
})

require("auto-session").setup({
	allowed_dirs = { vim.env.PROJECTS .. "/*", vim.env.WORK_PROJECTS .. "/*" },
})
V.keymap("n", "<leader>fs", ":AutoSession search<CR>")
