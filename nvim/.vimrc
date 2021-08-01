set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set guicursor=n-c:block,v-i-ci-ve:ver25,r-cr:hor20
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
set colorcolumn=80

"automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.vim/plugged')

" Auto bracket pairs
Plug 'jiangmiao/auto-pairs'

" Commenter
Plug 'tpope/vim-commentary'

" Python code formatter
Plug 'ambv/black'

" LSP plugin
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Jupyter sync extension
Plug 'untitled-ai/jupyter_ascending.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Themeing
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
call plug#end()

syntax enable
filetype plugin on

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

" Tree sitter highlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" Enable LSP
lua <<EOF
require'lspconfig'.pyright.setup{}
EOF

let mapleader = " "

" So I don't need to press Shift all the time
nnoremap ; :
vnoremap ; :

" Y behave like rest
nnoremap Y y$

" Copy/pasting remaps
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

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

" Jupyter_ascending remaps
nmap <space><space>x <Plug>JupyterExecute
nmap <space><space>X <Plug>JupyterExecuteAll

" Commenting line
nnoremap <leader>c <cmd>Commentary<cr>
vnoremap <leader>c <cmd>'<,'>Commentary<cr>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup thales
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
