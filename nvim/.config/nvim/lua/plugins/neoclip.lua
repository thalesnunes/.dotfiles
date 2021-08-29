-- Enable neoclip
require('neoclip').setup()

-- Clipboard manager
V.keymap('n', '<C-p>', ':lua require("telescope").extensions.neoclip.default()<CR>')
