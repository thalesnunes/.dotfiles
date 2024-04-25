return {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
        'nvim-telescope/telescope.nvim'
    },
	event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('neoclip').setup()
        V.keymap('n', '<leader>v', ':lua require("telescope").extensions.neoclip.default()<CR>')
        V.keymap('v', '<leader>v', ':lua require("telescope").extensions.neoclip.default()<CR>')
    end,
}
