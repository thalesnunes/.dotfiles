-- Telescope
require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        layout_strategy = 'flex',
        layout_config = {
            horizontal = {
            preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },

            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                -- horizontal = {
                --     preview_width = 0.9,
                -- },
            },
        },
        sorting_strategy = 'descending',
        color_devicons = true,
        mappings = {
            i = {
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
                ['<ESC>'] = 'close',
            },
            n = {
                ['g'] = 'move_to_top',
                ['G'] = 'move_to_bottom',
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore',
            '--hidden',
            '--trim',
        },
        file_ignore_patterns = {
            '.git',
            'node_modules',
            '.cache',
            '__pycache__',
            '%.pyc',
        },
    },
    pickers = {
        buffers = {
            initial_mode = 'normal',
            mappings = {
                n = {
                    ['<leader>q'] = 'delete_buffer',
                }
            }
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
    },
}

require('telescope').load_extension('fzf')

-- Find files using Telescope command-line sugar.
V.keymap('n', '<leader>ff', ':Telescope find_files hidden=true <CR>')
V.keymap('n', '<leader>fw', ':Telescope live_grep<CR>')
V.keymap('n', '<leader>b', ':Telescope buffers<CR>')
