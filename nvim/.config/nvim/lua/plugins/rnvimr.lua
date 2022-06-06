-- Make Ranger replace Netrw and be the file explorer
V.g.rnvimr_enable_ex = 1

-- Make Ranger to be hidden after picking a file
V.g.rnvimr_enable_picker = 1

-- Replace `$EDITOR` candidate with this command to open the selected file
V.g.rnvimr_edit_cmd = 'drop'

-- Disable a border for floating window
V.g.rnvimr_draw_border = 1

-- Hide the files included in gitignore
V.g.rnvimr_hide_gitignore = 0

-- Change the border's color
-- V.g.rnvimr_border_attr = {'fg' = 14, 'bg' = -1}

-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
V.g.rnvimr_enable_bw = 1

-- Add a shadow window, value is equal to 100 will disable shadow
V.g.rnvimr_shadow_winblend = 100

-- Draw border with both
-- V.g.rnvimr_ranger_cmd = {'ranger', '--cmd=set draw_borders both'}

-- Map Rnvimr action
-- V.g.rnvimr_action = {
--     ['<C-t>'] = 'NvimEdit tabedit',
--     ['<C-x>'] = 'NvimEdit split',
--     ['<C-v>'] = 'NvimEdit vsplit',
--     ['gw'] = 'JumpNvimCwd',
--     ['yw'] = 'EmitRangerCwd'
-- }

-- Fullscreen for initial layout
V.g.rnvimr_layout = {
    ['relative'] = 'editor',
    ['width'] = V.fn.winwidth('%'),
    ['height'] = V.fn.winheight('%')-2,
    ['col'] = 0,
    ['row'] = 0,
    ['style'] = 'minimal',
}

-- Link CursorLine into RnvimrNormal highlight in the Floating window
V.cmd('highlight link RnvimrNormal CursorLine')

V.keymap('n', '<leader>e', ':RnvimrToggle<CR>')
V.cmd [[
    augroup ranger
        au!
        autocmd Filetype rnvimr tnoremap <buffer><nowait> <ESC> <ESC>
    augroup end
]]

-- Run Rnvimr on startup when opened object is directory or [No name]
-- Else open ranger as background process
V.defer_fn(
    function()
        curr_path = V.fn.expand('%:p')
        if (V.fn.isdirectory(curr_path) == 1 or curr_path == '') then
            V.cmd('RnvimrToggle')
        else
            V.cmd('RnvimrStartBackground')
        end
    end,
    0
)
