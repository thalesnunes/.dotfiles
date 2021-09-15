-- Fast file switching with Harpoon
V.keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>')
V.keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

-- for num = 1,9,1 do
--     key = tostring(num)
--     V.keymap('n', '<leader>'..key, ':lua require("harpoon.ui").nav_file('..key..')<CR>')
-- end
V.keymap('n', '<c-j>', ':lua require("harpoon.ui").nav_file(1)<CR>')
V.keymap('n', '<c-k>', ':lua require("harpoon.ui").nav_file(2)<CR>')
V.keymap('n', '<c-l>', ':lua require("harpoon.ui").nav_file(3)<CR>')
V.keymap('n', '<c-m>', ':lua require("harpoon.ui").nav_file(4)<CR>')
V.keymap('n', '<leader>t', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
