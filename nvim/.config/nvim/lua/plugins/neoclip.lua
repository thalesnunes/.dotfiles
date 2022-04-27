-- Enable neoclip
require('neoclip').setup()

-- Clipboard manager
V.keymap('n', '<leader>v', ':lua require("telescope").extensions.neoclip.default()<CR>')
V.keymap('v', '<leader>v', ':lua require("telescope").extensions.neoclip.default()<CR>')
