return {
	"sindrets/diffview.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	cmd = "DiffviewOpen",
	keys = {
		{
			"<leader>fd",
			function()
				if require("diffview.lib").get_current_view() then
					vim.cmd.DiffviewClose()
				else
					vim.cmd.DiffviewOpen()
				end
			end,
			mode = "",
			desc = "[F]ile [D]iff",
		},
	},
	opts = {
		enhanced_diff_hl = true,
	},
}
