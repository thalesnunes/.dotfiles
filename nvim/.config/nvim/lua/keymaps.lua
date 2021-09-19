V.g.mapleader = ' '
V.g.maplocalleader = ' '

-- So I don't need to press Shift all the time
V.keymap('n', ';', ':')
V.keymap('v', ';', ':')
V.keymap('n', ':', ';')
V.keymap('v', ':', ';')

-- Y behave like rest
V.keymap('n', 'Y', 'y$')

-- Copy/pasting remaps
V.keymap('n', 'x', '"_x')
V.keymap('n', 'd', '"_d')
V.keymap('n', 'D', '"_D')
V.keymap('v', 'd', '"_d')
V.keymap('n', 'c', '"_c')
V.keymap('n', 'C', '"_C')
V.keymap('v', 'c', '"_c')

V.keymap('n', '<leader>d', '""d')
V.keymap('n', '<leader>D', '""D')
V.keymap('v', '<leader>d', '""d')

-- Keeping it centered
V.keymap('n', 'n', 'nzzzv')
V.keymap('n', 'N', 'Nzzzv')
V.keymap('n', 'J', 'mzJ`z')

-- Exit terminal mode
V.keymap('t', '<Esc>', '<C-\\><C-n>')

-- Add blank line
V.keymap('n', '<leader>o', 'o<esc>')
V.keymap('n', '<leader>O', 'O<esc>')

-- Copy and paste to system's clipboard
V.keymap('n', '<leader>y', '"+y')
V.keymap('n', '<leader>Y', '"+y$')
V.keymap('v', '<leader>y', '"+y')
V.keymap('n', '<leader>p', '"+p')
V.keymap('v', '<leader>p', '"+p')

-- Explorer keys
-- V.keymap('n', '<leader>ee', ':Ex<CR>')
-- V.keymap('v', '<leader>ee', ':Ex<CR>')
-- V.keymap('n', '<leader>ev', ':Vex<CR>')
-- V.keymap('v', '<leader>ev', ':Vex<CR>')
-- V.keymap('n', '<leader>eh', ':Sex<CR>')
-- V.keymap('v', '<leader>eh', ':Sex<CR>')

-- Keep indenting selected
V.keymap('v', '<', '<gv')
V.keymap('v', '>', '>gv')

-- Move selected lines up/down
V.keymap('x', 'J', ':move \'>+1<CR>gv-gv')
V.keymap('x', 'K', ':move \'<-2<CR>gv-gv')

-- Buffer switching and delete
V.keymap('n', '<leader>l', ':bnext<CR>')
V.keymap('v', '<leader>l', ':bnext<CR>')
V.keymap('n', '<leader>h', ':bprev<CR>')
V.keymap('v', '<leader>h', ':bprev<CR>')
V.keymap('n', '<leader>q', ':bdelete<CR>')

-- Reload config
V.keymap('n', '<leader>r', ':luafile $MYVIMRC<CR>')
