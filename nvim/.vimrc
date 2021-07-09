set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap

set guicursor=
set relativenumber
set nu

set nohlsearch
set incsearch
set hidden
set noerrorbells
set noshowmode

set ignorecase
set smartcase

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=8
set termguicolors
set colorcolumn=100

call plug#begin('~/.vim/plugged')
" Python code formatter
Plug 'ambv/black'

" LSP plugin
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Themeing
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
call plug#end()

syntax enable

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             ['readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'gitbranch'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
colorscheme dracula
highlight Normal guibg=none

let mapleader = " "

" So I don't need to press Shift all the time
nnoremap ; :
vnoremap ; :

" Explorer keys
nnoremap <leader>ee :Ex<CR>
vnoremap <leader>ee :Ex<CR>
nnoremap <leader>ve :Vex<CR>
vnoremap <leader>ve :Vex<CR>

" Copy and paste to system's clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup thales
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
