vim.pack.add({
	"https://github.com/samir-roy/code-bridge.nvim",
})

require("code-bridge").setup({
	tmux = {
		target_mode = "window_name",
		window_name = "agent",
		switch_to_target = true,
		find_node_process = true,
	},
	interactive = {
		use_telescope = true,
	},
})

V.keymap("n", "<leader>as", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
V.keymap("v", "<leader>as", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
V.keymap("n", "<leader>ai", ":CodeBridgeTmuxInteractive<CR>", { desc = "Interactive prompt to claude" })
V.keymap("v", "<leader>ai", ":CodeBridgeTmuxInteractive<CR>", { desc = "Interactive selection to claude" })
V.keymap("n", "<leader>ad", ":CodeBridgeTmuxDiff<CR>", { desc = "Send git diff to claude" })
