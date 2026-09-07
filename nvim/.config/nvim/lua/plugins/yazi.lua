return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>e",
			function()
				require("yazi").yazi()
			end,
			desc = "Open Yazi (at current file)",
		},
		{
			"<leader>E",
			function()
				require("yazi").yazi(nil, vim.fn.getcwd())
			end,
			desc = "Open Yazi (in nvim cwd)",
		},
	},
	opts = {
		open_for_directories = true,
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_border = "rounded",
		keymaps = {
			show_help = "<f1>",
		},
	},
	config = function(_, opts)
		require("yazi").setup(opts)

		-- Run Yazi on startup when opened with [No Name] (empty buffer without file args)
		vim.defer_fn(function()
			local curr_path = vim.fn.expand("%:p")
			-- open_for_directories handles directories; this handles empty [No Name] buffer
			if curr_path == "" and vim.fn.argc() == 0 and vim.bo.buftype == "" then
				require("yazi").yazi()
			end
		end, 0)
	end,
}
