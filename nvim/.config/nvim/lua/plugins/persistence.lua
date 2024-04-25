return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
        -- restore the session for the current directory
        V.keymap("n", "<leader>ss", "<cmd>lua require('persistence').load()<cr>", {})
        -- restore the last session
        V.keymap("n", "<leader>sl", "<cmd>lua require('persistence').load({ last = true })<cr>", {})
        -- stop Persistence => session won't be saved on exit
        V.keymap("n", "<leader>sq", "<cmd>lua require('persistence').stop()<cr>", {})
    end
}
