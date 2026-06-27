vim.pack.add({
	"https://github.com/jupyter-vim/jupyter-vim",
})

vim.g["jupyter_mapkeys"] = 0
vim.g["jupyter_cell_separators"] = { "##", "#%%", "# %%", "# <codecell>", "    # %%" }
vim.g["jupyter_mapkeys"] = 0

V.keymap("n", "<leader>jc", ":JupyterConnect<CR>")
V.keymap("n", "<leader>ja", "o<CR># %%<CR><Esc>")
V.keymap("n", "<leader><CR>", ":JupyterSendCell<CR>")
V.keymap("v", "<leader><CR>", ":JupyterSendRange<CR>")
V.keymap("n", "<leader>jd", ":JupyterCd %:p:h<CR>")
V.keymap(
	"n",
	"<leader>jr",
	':silent !i3-msg -q "workspace 9:Terminal, exec foot -- jupyconsole $(basename $(pwd))"<CR>'
)
