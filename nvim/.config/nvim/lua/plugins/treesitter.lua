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
}
