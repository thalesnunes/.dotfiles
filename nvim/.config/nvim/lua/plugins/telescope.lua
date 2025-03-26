return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {
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
                        ['<CR>'] = function(prompt_bufnr)
                            local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                            local multi = picker:get_multi_selection()
                            if not vim.tbl_isempty(multi) then
                                require('telescope.actions').close(prompt_bufnr)
                                for _, j in pairs(multi) do
                                    if j.path ~= nil then
                                        vim.cmd(string.format('%s %s', 'edit', j.path))
                                    end
                                end
                            else
                                require('telescope.actions').select_default(prompt_bufnr)
                            end
                        end
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
                    'star_schema',
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
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')

            function live_grep_git_dir()
                local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
                git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
                require('telescope.builtin').live_grep({cwd=git_dir})
            end

            -- Find files using Telescope command-line sugar.
            V.keymap('n', '<leader>ff', ':Telescope git_files hidden=true recurse_submodules=true<CR>')
            V.keymap('n', '<leader>fw', ':lua live_grep_git_dir()<CR>')
            V.keymap('n', '<leader>b', ':Telescope buffers<CR>')
            V.keymap('n', '<leader>H', ':Telescope help_tags<CR>')
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    }

}
