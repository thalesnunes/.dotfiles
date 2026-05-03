return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		allowed_dirs = { vim.env.PROJECTS .. "/*", vim.env.WORK_PROJECTS .. "/*" },
	},
	config = function(_, opts)
		require("auto-session").setup(opts)
		V.keymap("n", "<leader>fs", ":AutoSession search<CR>")
	end,
}
