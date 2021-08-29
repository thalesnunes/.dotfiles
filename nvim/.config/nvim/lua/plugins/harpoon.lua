-- Fast file switching with Harpoon
V.keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>')
V.keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

V.keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>')
V.keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>')
V.keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>')
V.keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>')
V.keymap('n', '<leader>t', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
