vim.pack.add({
	"https://github.com/nvim-mini/mini.comment",
})

require("mini.comment").setup({
	options = {
		ignore_blank_line = true,
	},
	mappings = {
		comment = "<leader>c",
		comment_line = "<leader>cc",
		comment_visual = "<leader>c",
		textobject = "<leader>c",
	},
})
