require('hop').setup()

-- Fast movement
V.keymap('n', '<leader>ff', ':lua require("hop").hint_words()<CR>')
V.keymap('n', '<leader>fp', ':lua require("hop").hint_patterns()<CR>')
V.keymap('n', '<leader>fc', ':lua require("hop").hint_char2()<CR>')
V.keymap('n', '<leader>fl', ':lua require("hop").hint_lines()<CR>')
