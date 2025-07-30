return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"telescope.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		attach_to_untracked = true,
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
	},
}
