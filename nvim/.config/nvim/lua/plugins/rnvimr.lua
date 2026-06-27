vim.pack.add({
	"https://github.com/kevinhwang91/rnvimr",
})

vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_edit_cmd = "drop"
vim.g.rnvimr_draw_border = 1
vim.g.rnvimr_hide_gitignore = 0
vim.g.rnvimr_enable_bw = 1
vim.g.rnvimr_shadow_winblend = 100

vim.g.rnvimr_layout = {
	relative = "editor",
	width = vim.o.columns,
	height = math.floor(0.9 * vim.o.lines),
	col = 0,
	row = 1,
	style = "minimal",
}

vim.cmd("highlight link RnvimrNormal CursorLine")

V.keymap("n", "<leader>e", ":RnvimrToggle<CR>")

vim.api.nvim_create_autocmd("Filetype", {
	group = vim.api.nvim_create_augroup("ranger", { clear = true }),
	pattern = "rnvimr",
	callback = function()
		V.buf_keymap(0, "t", "<ESC>", "<ESC>", { nowait = true })
	end,
})

vim.defer_fn(function()
	if vim.env.USER == "root" then
		return
	end

	local curr_path = vim.fn.expand("%:p")
	if not vim.g.rnvimr_skip_toggle and (vim.fn.isdirectory(curr_path) == 1 or curr_path == "") then
		vim.cmd("RnvimrToggle")
	else
		vim.cmd("RnvimrStartBackground")
	end
end, 0)
