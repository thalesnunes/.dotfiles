vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
})

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

require("nvim-treesitter").install(parsers)
