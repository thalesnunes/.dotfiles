-- Jupyter-vim remaps
V.g['jupyter_mapkeys'] = 0

-- Connect to kernel
V.keymap('n', '<leader>jc', ':JupyterConnect<CR>')

-- Add cell
V.keymap('n', '<leader>ja', 'o# %%<Esc>o<Esc>')

-- Send cell to kernel
V.keymap('n', '<leader><CR>', ':JupyterSendCell<CR>')
V.keymap('v', '<leader><CR>', ':JupyterSendRange<CR>')

-- Send a selection of lines
-- V.keymap('v', '<leader><CR>', ':JupyterRunVisual<CR>')

-- Update shell
-- V.keymap('n', '<leader>ju', ':JupyterUpdateShell<CR>')

-- Change to directory of current file
V.keymap('n', '<leader>jd', ':JupyterCd %:p:h<CR>')

-- Debugging maps
-- V.keymap('n', '<localleader>jb', ':PythonSetBreak<CR>')
