-- Fast file switching with Harpoon
V.keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>')
V.keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

for num = 1,9,1 do
    key = tostring(num)
    V.keymap('n', '<leader>'..key, ':lua require("harpoon.ui").nav_file('..key..')<CR>')
end
V.keymap('n', '<leader>t', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
