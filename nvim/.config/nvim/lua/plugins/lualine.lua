return {
	"hoob3rt/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "dracula-nvim",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(mode)
							return mode:sub(1, 1)
						end,
					},
				},
				lualine_b = { "branch" },
				lualine_c = {
					"filename",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
					},
				},
				lualine_x = {
					{
						"diff",
						color_added = "#02f702",
						color_modified = "#efd402",
						color_removed = "#ea000f",
					},
				},
				lualine_y = {
					{
						"lsp_status",
						icon = "",
						symbols = {
							-- Standard unicode symbols to cycle through for LSP progress:
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							-- Standard unicode symbol for when LSP is done:
							done = "✓",
							-- Delimiter inserted between LSP names:
							separator = " ",
						},
						-- List of LSP names to ignore (e.g., `null-ls`):
						ignore_lsp = {},
					},
					"filetype",
				},
				lualine_z = { "location" },
			},
		})
	end,
}
