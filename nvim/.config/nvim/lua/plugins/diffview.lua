vim.pack.add({
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("diffview").setup({
	enhanced_diff_hl = true,
})

V.keymap("n", "<leader>fd", function()
	if require("diffview.lib").get_current_view() then
		vim.cmd.DiffviewClose()
	else
		vim.cmd.DiffviewOpen()
	end
end, { desc = "[F]ile [D]iff" })
