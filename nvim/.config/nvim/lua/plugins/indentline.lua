vim.pack.add({
	"https://github.com/nvim-mini/mini.indentscope",
})

require("mini.indentscope").setup({
	mappings = {
		object_scope = "",
		object_scope_with_border = "",
		goto_top = "",
		goto_bottom = "",
	},
	symbol = "╎",
})
