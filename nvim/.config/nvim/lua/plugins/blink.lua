vim.pack.add({
	"https://github.com/saghen/blink.cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/folke/lazydev.nvim",
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	keymap = {
		preset = "none",

		["<A-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },

		["<A-k>"] = { "select_prev", "fallback" },
		["<A-j>"] = { "select_next", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},

	cmdline = {
		keymap = { preset = "inherit" },
		completion = {
			menu = { auto_show = true },
			list = {
				selection = { preselect = false, auto_insert = true },
			},
		},
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
		list = {
			selection = { preselect = false, auto_insert = true },
		},
	},

	sources = {
		default = { "snippets", "lsp", "path", "buffer", "lazydev" },
		providers = {
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},

	snippets = { preset = "luasnip" },

	fuzzy = { implementation = "lua" },

	signature = { enabled = true },
})
