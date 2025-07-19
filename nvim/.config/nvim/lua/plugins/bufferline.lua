return {
    'akinsho/bufferline.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    version = "*",
    opts = {
        options = {
            diagnostics = 'nvim_lsp',
            separator_style = { '', '' },
            show_close_icon = false,
            show_buffer_close_icons = false,
            tab_size = 15,
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local s = ' '
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == 'error' and ' '
                    or (e == 'warning' and ' ' or ' ' )
                    s = s .. n .. sym
                end
                return s
            end,
            custom_filter = function(buf_number, _)
                -- filter out by buffer name
                if vim.fn.bufname(buf_number) ~= '[No Name]' then
                    return true
                end
            end,
            offsets = {
                {
                    filetype = 'undotree',
                    text = 'Undotree',
                    highlight = 'PanelHeading',
                },
                {
                    filetype = 'packer',
                    text = 'Packer',
                    highlight = 'PanelHeading',
                },
            },
        },
    },
    config = function(_, opts)
        require('bufferline').setup(opts)
        -- These commands will navigate through buffers in order regardless of which mode you are using
        -- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
        V.keymap('n', '<leader>l', ':BufferLineCycleNext<CR>')
        V.keymap('n', '<leader>h', ':BufferLineCyclePrev<CR>')

        -- These commands will move the current buffer backwards or forwards in the bufferline
        V.keymap('n', '<leader>>', ':BufferLineMoveNext<CR>')
        V.keymap('n', '<leader><', ':BufferLineMovePrev<CR>')
    end,
}
