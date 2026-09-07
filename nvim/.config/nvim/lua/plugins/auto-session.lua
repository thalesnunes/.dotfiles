return {
	"rmagatti/auto-session",
	lazy = false,
	cond = function()
		return vim.loop.getuid() ~= 0
	end,
	opts = {
		allowed_dirs = { (vim.env.PROJECTS or "") .. "/*", (vim.env.WORK_PROJECTS or "") .. "/*" },
	},
	config = function(_, opts)
		require("auto-session").setup(opts)
		V.keymap("n", "<leader>fs", ":AutoSession search<CR>")
	end,
}
