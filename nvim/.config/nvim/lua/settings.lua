vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.guicursor = 'n-c:block,v-i-ci-ve:ver25,r-cr:hor20'
vim.opt.nu = true
vim.opt.mouse = "a"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.errorbells = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undodir'

vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true

vim.opt.laststatus = 2
vim.opt.showmode = false

-- Disable distribution plugins
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit'
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local packer_group = augroup('Packer', { clear = true })
local yank_group = augroup('highlight_yank', { clear = true })
local thales_group = augroup('thales', { clear = true })

autocmd('BufWritePost', {
    group = packer_group,
    pattern = { 'init.lua', 'keymaps.lua', 'plugins.lua', 'settings.lua' },
    command = 'PackerCompile',
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            timeout = 40,
        })
    end,
})

autocmd('BufWritePre', {
    group = thales_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

vim.cmd [[
    syntax enable
    colorscheme dracula
    filetype plugin on
    highlight Normal guibg=none
    highlight CursorLine guibg=#21222A
]]
