return {
	"nvim-mini/mini.indentscope",
	version = false,
	event = "VeryLazy",
	opts = {
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			-- Textobjects
			object_scope = "",
			object_scope_with_border = "",

			-- Motions (jump to respective border line; if not present - body line)
			goto_top = "",
			goto_bottom = "",
		},

		-- Which character to use for drawing scope indicator
		symbol = "╎",
	},
}
