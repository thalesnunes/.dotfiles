return {
    "ggandor/leap.nvim",
    dependencies = {
        'tpope/vim-repeat'
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        V.keymap('n', 's', '<Plug>(leap-anywhere)')
        V.keymap('x', 's', '<Plug>(leap)')
        V.keymap('o', 's', '<Plug>(leap-forward)')
        V.keymap('o', 'S', '<Plug>(leap-backward)')
    end,
}
