-- Enable LSP
local nvim_lsp = require('lspconfig')

local servers = { 'pylsp', 'texlab' }

local basic_keybinds = function(bufnr)
    V.buf_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    V.buf_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    V.buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    V.buf_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    V.buf_keymap(bufnr, 'n', '<a-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    V.buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    V.buf_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    V.buf_keymap(bufnr, 'n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()()<CR>')
    V.buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    V.buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    -- V.buf_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

local texlab_keybinds = function(bufnr)
    V.buf_keymap(bufnr, 'n', 'j', 'gj')
    V.buf_keymap(bufnr, 'v', 'j', 'gj')
    V.buf_keymap(bufnr, 'n', 'k', 'gk')
    V.buf_keymap(bufnr, 'v', 'k', 'gk')
    V.cmd(':set wrap')
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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, server in ipairs(servers) do
  nvim_lsp[server].setup {
    on_attach = function(client, bufnr)
        on_attach(server, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
