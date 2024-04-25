return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-treesitter'
    },
	event = { "BufReadPre", "BufNewFile" },
    config = function()
        local nvim_lsp = require('lspconfig')

        local servers = {
            'pylsp',
            'bashls',
            'lua_ls'
        }

        local basic_keybinds = function(bufnr)
            V.buf_keymap(bufnr, 'n', 'gD', vim.lsp.buf.declaration)
            V.buf_keymap(bufnr, 'n', 'gd', vim.lsp.buf.definition)
            V.buf_keymap(bufnr, 'n', 'K', vim.lsp.buf.hover)
            V.buf_keymap(bufnr, 'n', 'gi', vim.lsp.buf.implementation)
            V.buf_keymap(bufnr, 'n', '<a-k>', vim.lsp.buf.signature_help)
            -- V.buf_keymap(bufnr, 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
            -- V.buf_keymap(bufnr, 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
            -- V.buf_keymap(bufnr, 'n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
            -- V.buf_keymap(bufnr, 'n', '<leader>D', vim.lsp.buf.type_definition)
            V.buf_keymap(bufnr, 'n', '<leader>rn', vim.lsp.buf.rename)
            -- V.buf_keymap(bufnr, 'n', '<leader>ca', vim.lsp.buf.code_action)
            V.buf_keymap(bufnr, 'n', 'gr', vim.lsp.buf.references)
            V.buf_keymap(bufnr, 'n', '<leader>sd', vim.diagnostic.open_float)
            V.buf_keymap(bufnr, 'n', '[d', vim.diagnostic.goto_prev)
            V.buf_keymap(bufnr, 'n', ']d', vim.diagnostic.goto_next)
            -- V.buf_keymap(bufnr, 'n', '<leader>q', vim.lsp.diagnostic.set_loclist)
            -- V.buf_keymap(bufnr, 'n', '<leader>f', vim.lsp.buf.formatting)
        end

        local texlab_keybinds = function(bufnr)
            V.buf_keymap(bufnr, 'n', 'j', 'gj')
            V.buf_keymap(bufnr, 'v', 'j', 'gj')
            V.buf_keymap(bufnr, 'n', 'k', 'gk')
            V.buf_keymap(bufnr, 'v', 'k', 'gk')
            vim.cmd(':set wrap')
        end

        local languages_keybinds = {
            texlab = texlab_keybinds
        }

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(server, bufnr)
            basic_keybinds(bufnr)
            local language_keys = languages_keybinds[server]
            if language_keys ~= nil then
                language_keys(bufnr)
            end
        end

        local custom_settings = {
            sumneko_lua = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        }

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        for _, server in ipairs(servers) do
            nvim_lsp[server].setup {
                on_attach = function(_, bufnr)
                    on_attach(server, bufnr)
                end,
                flags = {
                    debounce_text_changes = 150,
                },
                settings = custom_settings[server]
            }
        end
    end,
}
