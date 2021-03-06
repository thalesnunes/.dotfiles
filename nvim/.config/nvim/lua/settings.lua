V.opt.tabstop = 4
V.opt.softtabstop = 4
V.opt.shiftwidth = 4
V.opt.expandtab = true
V.opt.smartindent = true
V.opt.wrap = false

V.opt.guicursor = 'n-c:block,v-i-ci-ve:ver25,r-cr:hor20'
V.opt.nu = true
V.opt.mouse = "a"

V.opt.hlsearch = false
V.opt.incsearch = true
V.opt.hidden = true
V.opt.errorbells = false

V.opt.ignorecase = true
V.opt.smartcase = true

V.opt.swapfile = false
V.opt.backup = false
V.opt.undofile = true
V.opt.undodir = V.fn.stdpath('cache') .. '/undodir'

V.opt.scrolloff = 8
V.opt.termguicolors = true
V.opt.colorcolumn = '80'
V.opt.cursorline = true
V.opt.cursorlineopt = "number"

V.opt.laststatus = 2
V.opt.showmode = false

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
  V.g['loaded_' .. plugin] = 1
end

V.cmd [[
    syntax enable
    colorscheme dracula
    filetype plugin on
    highlight Normal guibg=none

    augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
        autocmd BufWritePost keymaps.lua PackerCompile
        autocmd BufWritePost plugins.lua PackerCompile
        autocmd BufWritePost settings.lua PackerCompile
    augroup end

    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    augroup END

    augroup thales
        autocmd!
        autocmd BufWritePre * %s/\s\+$//e
    augroup END
]]
