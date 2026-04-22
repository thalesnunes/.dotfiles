V.keymap("n", "<leader>fs", ":AutoSession search<CR>")

return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		allowed_dirs = { vim.env.PROJECTS .. "/*", vim.env.WORK_PROJECTS .. "/*" },
	},
}
