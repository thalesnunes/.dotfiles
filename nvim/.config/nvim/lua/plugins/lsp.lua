local servers = {
    'pylsp',
    'bashls',
    'lua_ls',
    'sqruff',
}

local basic_keybinds = function(bufnr)
    V.buf_keymap(bufnr, 'n', 'gD', vim.lsp.buf.declaration)
    V.buf_keymap(bufnr, 'n', 'gd', vim.lsp.buf.definition)
    V.buf_keymap(bufnr, 'n', 'K', vim.lsp.buf.hover)
    V.buf_keymap(bufnr, 'n', 'gi', vim.lsp.buf.implementation)
    V.buf_keymap(bufnr, 'n', '<a-k>', vim.lsp.buf.signature_help)
    V.buf_keymap(bufnr, 'n', '<leader>D', vim.lsp.buf.type_definition)
    V.buf_keymap(bufnr, 'n', '<leader>rn', vim.lsp.buf.rename)
    V.buf_keymap(bufnr, 'n', '<leader>ca', vim.lsp.buf.code_action)
    V.buf_keymap(bufnr, 'n', 'gr', vim.lsp.buf.references)
    V.buf_keymap(bufnr, 'n', '<leader>sd', vim.diagnostic.open_float)
    V.buf_keymap(bufnr, 'n', '[d', vim.diagnostic.goto_prev)
    V.buf_keymap(bufnr, 'n', ']d', vim.diagnostic.goto_next)
    V.buf_keymap(bufnr, 'n', '<leader>fm', vim.lsp.buf.format)
end

local languages_keybinds = {
    texlab = function(bufnr)
        V.buf_keymap(bufnr, 'n', 'j', 'gj')
        V.buf_keymap(bufnr, 'v', 'j', 'gj')
        V.buf_keymap(bufnr, 'n', 'k', 'gk')
        V.buf_keymap(bufnr, 'v', 'k', 'gk')
        vim.cmd(':set wrap')
    end,
    sqruff = function(bufnr)
        V.buf_keymap(bufnr, 'n', '<leader>fm', ":silent !sleek %<CR>")
        V.buf_keymap(bufnr, 'v', '<leader>fm', ":!sleek<CR>")
    end
}

local custom_settings = {
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}


return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-treesitter'
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        for _, server in ipairs(servers) do
            vim.lsp.config[server] = {
                settings = custom_settings[server],
                on_attach = function(_, bufnr)
                    basic_keybinds(bufnr)
                    local language_keys = languages_keybinds[server]
                    if language_keys ~= nil then
                        language_keys(bufnr)
                    end
                end
            }
            vim.lsp.enable(server)
        end
    end,
}
