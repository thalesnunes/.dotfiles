vim.pack.add({
	{ src = "https://github.com/Mofiqul/dracula.nvim" },
})

require("dracula").setup({})

vim.cmd([[
    colorscheme dracula
    highlight Normal guibg=none
    highlight CursorLine guibg=#21222A
]])
