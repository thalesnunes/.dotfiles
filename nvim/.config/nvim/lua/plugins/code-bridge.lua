return {
	"samir-roy/code-bridge.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>as", ":CodeBridgeTmux<CR>", mode = "n", desc = "Send file to claude" },
		{ "<leader>as", ":CodeBridgeTmux<CR>", mode = "v", desc = "Send selection to claude" },

		{ "<leader>ai", ":CodeBridgeTmuxInteractive<CR>", mode = "n", desc = "Interactive prompt to claude" },
		{ "<leader>ai", ":CodeBridgeTmuxInteractive<CR>", mode = "v", desc = "Interactive selection to claude" },
		{ "<leader>ad", ":CodeBridgeTmuxDiff<CR>", mode = "n", desc = "Send git diff to claude" },
	},
	opts = {
		tmux = {
			target_mode = "window_name", -- 'window_name', 'current_window', 'find_process'
			window_name = "claude", -- used when target_mode = 'window_name'
			process_name = "claude", -- used when target_mode = 'current_window' or 'find_process'
			switch_to_target = true, -- whether to switch to target after sending
			find_node_process = true, -- whether to look for a node.js process
		},
		interactive = {
			use_telescope = true, -- use telescope for interactive prompts (default: true)
		},
	},
}
