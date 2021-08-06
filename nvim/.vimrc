set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap

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

" Auto bracket pairs and surround
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

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

" Telescope and Harpoon
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/harpoon'

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
      \   'gitbranch': 'FugitiveHead'
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
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d
nnoremap <leader>c ""c
nnoremap <leader>C ""C
vnoremap <leader>c ""c

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Add blank line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Copy and paste to system's clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Explorer keys
nnoremap <leader>ee :Ex<CR>
vnoremap <leader>ee :Ex<CR>
nnoremap <leader>ev :Vex<CR>
vnoremap <leader>ev :Vex<CR>
nnoremap <leader>eh :Sex<CR>
vnoremap <leader>eh :Sex<CR>

" Buffer switching and delete
nnoremap <leader>l :bnext<CR>
vnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>
vnoremap <leader>h :bprev<CR>
nnoremap <leader>q :bdelete<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Fast file switching with Harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>t :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>t :lua require("harpoon.term").gotoTerminal(2)<CR>

" Jupyter_ascending remaps
nmap <space><space>x <Plug>JupyterExecute
nmap <space><space>X <Plug>JupyterExecuteAll

" Commenting line
nnoremap <leader>c :Commentary<CR>
vnoremap <leader>c :'<,'>Commentary<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup thales
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
