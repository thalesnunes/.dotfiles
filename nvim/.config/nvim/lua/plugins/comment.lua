-- Commentary toggling
require('nvim_comment').setup {
    comment_empty = false,
    create_mappings = false,
}

-- Commenting line
V.keymap('n', '<leader>c', ':CommentToggle<CR>')
V.keymap('v', '<leader>c', ':CommentToggle<CR>')
