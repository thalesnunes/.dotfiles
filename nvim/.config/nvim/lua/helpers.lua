local M = {}

M.cmd = vim.cmd
M.opt = vim.opt
M.fn = vim.fn
M.g = vim.g
M.execute = vim.api.nvim_command
M.lsp = vim.lsp

function M.keymap(mode, new_keymap, command, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, new_keymap, command, options)
end

function M.buf_keymap(buf, mode, new_keymap, command, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_buf_set_keymap(buf, mode, new_keymap, command, options)
end

return M
