return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"json",
					"lua",
					"python",
					"sql",
					"regex",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = 5000,
					colors = {
						"#ee82ee",
						"#fde01a",
						"#3cd10c",
						"#f68a1e",
						"#87cefa",
						"#d12229",
					},
				},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "BufReadPre", "BufNewFile" },
	},
}
