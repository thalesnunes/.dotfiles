return {
	dir = vim.fn.stdpath("config") .. "/lua/tools",
	name = "sql-runner",
	event = "VeryLazy",
	config = function()
		require("tools.sql-runner").setup({
			commands = {
				snowflake = "snowsql --noup --abort-detached-query -o friendly=false -o quiet=true -f %s -o output_file=%s",
			},
			default_command = "snowflake",
			use_tmux_window = true,
		})

		V.keymap({ "n", "v" }, "<leader>rq", ":RunSQL<CR>", { desc = "Run SQL query with selected backend" })
		V.keymap("n", "<leader>rs", ":SelectSqlCmd<CR>", { desc = "Select SQL backend" })
		V.keymap("n", "<leader>rv", ":ViewSqlOutput<CR>", { desc = "View last SQL output in tmux window" })
	end,
}
