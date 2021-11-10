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
        colors = {
            "#d12229",
            "#f68a1e",
            "#fde01a",
            "#3cd10c",
            "#87cefa",
            "#ee82ee",
        },
    }
}
