vim.pack.add({
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/nvim-mini/mini.pairs",
})

require("mini.surround").setup({
	custom_surroundings = {
		["("] = { output = { left = "(", right = ")" } },
		["["] = { output = { left = "[", right = "]" } },
		["{"] = { output = { left = "{", right = "}" } },

		[")"] = { output = { left = "( ", right = " )" } },
		["]"] = { output = { left = "[ ", right = " ]" } },
		["}"] = { output = { left = "{ ", right = " }" } },
	},
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",
	},
})

require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	skip_unbalanced = true,
	markdown = true,
})
