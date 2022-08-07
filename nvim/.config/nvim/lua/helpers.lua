local M = {}

function M.keymap(mode, new_keymap, command, opts)
    local options = {remap = false, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, new_keymap, command, options)
end

function M.buf_keymap(buf, mode, new_keymap, command, opts)
    local options = {remap = false, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    options = vim.tbl_extend('force', options, {buffer = buf})
    vim.keymap.set(mode, new_keymap, command, options)
end

return M
