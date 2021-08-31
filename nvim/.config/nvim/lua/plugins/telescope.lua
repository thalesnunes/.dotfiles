-- Telescope
require('telescope').setup {
    defaults = {
        initial_mode = 'normal'

    },
    pickers = {
        buffers = {
            previewer = false,
            mappings = {
                i = {
                    ["<leader>q"] = "delete_buffer"
                },
                n = {
                    ["<leader>q"] = "delete_buffer"
                }
            }
        }
    }
}

-- Find files using Telescope command-line sugar.
V.keymap('n', '<leader>sf', ':Telescope find_files<CR>')
V.keymap('n', '<leader>sa', ':Telescope find_files hidden=true <CR>')
V.keymap('n', '<leader>sw', ':Telescope live_grep<CR>')
V.keymap('n', '<leader>b', ':Telescope buffers<CR>')
