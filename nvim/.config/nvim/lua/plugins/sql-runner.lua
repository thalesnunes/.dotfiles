return {
	dir = vim.fn.stdpath("config") .. "/lua/tools",
	name = "sql-runner",
	event = "VeryLazy",
	config = function()
		require("tools.sql-runner").setup({
			commands = {
				snowflake = "snowsql --noup --abort-detached-query -o friendly=false -o quiet=true -o output_file=",
			},
			default_command = "snowflake",
			use_tmux_window = true,
		})

		V.keymap("n", "<leader>rq", ":RunSQL<CR>", { desc = "Run SQL query under cursor with selected backend" })
		V.keymap("v", "<leader>rq", ":RunSQL<CR>", { desc = "Run SQL visual selected query with selected backend" })
		V.keymap("n", "<leader>rs", ":SelectSqlCmd<CR>", { desc = "Select SQL backend" })
		V.keymap("n", "<leader>rv", ":ViewSqlOutput<CR>", { desc = "View last SQL output in tmux window" })
	end,
}
