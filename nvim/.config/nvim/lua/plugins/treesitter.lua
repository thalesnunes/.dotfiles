return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		init = function()
			local parsers = {
				"bash",
				"json",
				"lua",
				"python",
				"sql",
				"regex",
				"markdown",
				"markdown_inline",
				"yaml",
				"dockerfile",
			}

			local group = vim.api.nvim_create_augroup("ThalesTreesitter", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
				group = group,
				callback = function()
					if vim.bo.buftype ~= "" then
						return
					end

					pcall(vim.treesitter.start, 0)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VeryLazy",
				once = true,
				callback = function()
					require("nvim-treesitter").install(parsers)
				end,
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
