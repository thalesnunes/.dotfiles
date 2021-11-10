require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "json",
        "lua",
        "python",
    },
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 5000,
        -- colors = {},
    }
}
