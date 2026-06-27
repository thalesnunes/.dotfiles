vim.pack.add({
	"https://github.com/hoob3rt/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/noice.nvim",
	"https://github.com/Mofiqul/dracula.nvim",
})

local custom_dracula = require("lualine.themes.dracula-nvim")
local new_bg = require("dracula").colors().bg
custom_dracula.normal.b.bg = new_bg
custom_dracula.insert.b.bg = new_bg
custom_dracula.visual.b.bg = new_bg
custom_dracula.replace.b.bg = new_bg
custom_dracula.command.b.bg = new_bg
custom_dracula.inactive.b.bg = new_bg

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_dracula,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				separator = { left = "", right = "" },
				right_padding = 2,
				fmt = function(str)
					return str:sub(1, 1)
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
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
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
				icon = "",
				symbols = {
					spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					done = "✓",
					separator = " ",
				},
				ignore_lsp = {},
			},
			"filetype",
		},
		lualine_z = {
			{
				"location",
				separator = { left = "", right = "" },
			},
		},
	},
})
