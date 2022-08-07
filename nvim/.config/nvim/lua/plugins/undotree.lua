-- Cleaner looks
vim.g.undotree_ShortIndicators = 1
-- Changes focus to undotree
vim.g.undotree_SetFocusWhenToggle = 1
-- Changes focus to undotree
vim.g.undotree_SetFocusWhenToggle = 1

V.keymap('n', '<leader>u', ':UndotreeToggle<CR>')
V.keymap('v', '<leader>u', ':UndotreeToggle<CR>')
