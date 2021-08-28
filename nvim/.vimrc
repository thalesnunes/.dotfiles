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
Plug 'machakann/vim-sandwich'
Plug 'AckslD/nvim-neoclip.lua'

" Commenter
Plug 'tpope/vim-commentary'

" Python code formatter
Plug 'ambv/black'

" LSP plugin
Plug 'neovim/nvim-lspconfig'

" Install nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'

" Highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Jupyter plugin
Plug 'jupyter-vim/jupyter-vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Telescope and Harpoon
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/harpoon'

" Themeing
Plug 'mboughaba/i3config.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

syntax enable
filetype plugin on

set laststatus=2
colorscheme dracula
set noshowmode
highlight Normal guibg=none

lua <<EOF
-- Lualine config
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = {'|', '|'},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
        'filename',
        {
            'diagnostics',
            sources = {'nvim_lsp'}
        }
    },
    lualine_x = {'filetype'},
    lualine_y = {
        {
            'diff',
            color_added = '#02f702',
            color_modified = '#efd402',
            color_removed = '#ea000f'
        }
    },
    lualine_z = {'location'}
  }
}

-- Tree sitter highlight
require'nvim-treesitter.configs'.setup {
  ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

-- Enable LSP
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Enable auto-completion
local cmp = require('cmp')
cmp.setup {
-- You can set mappings if you want
    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    -- You should specify your *installed* sources.
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
}

-- Telescope
require'telescope'.setup {
    defaults = {
        initial_mode = 'normal'
    },
    pickers = {
        buffers = {
            previewer = false,
            mappings = {
                i = {
                    ["<leader>q"] = "delete_buffer"
                },
                n = {
                    ["<leader>q"] = "delete_buffer"
                }
            }
        }
    }
}

-- Enable neoclip
require'neoclip'.setup()
EOF

let mapleader = " "

" So I don't need to press Shift all the time
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

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
nnoremap <silent><leader>l :bnext<CR>
vnoremap <silent><leader>l :bnext<CR>
nnoremap <silent><leader>h :bprev<CR>
vnoremap <silent><leader>h :bprev<CR>
nnoremap <silent><leader>q :bdelete<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>

" Fast file switching with Harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>t :lua require("harpoon.term").gotoTerminal(1)<CR>

" Clipboard manager
nnoremap <silent><C-p> :lua require("telescope").extensions.neoclip.default()<CR>

" Jupyter-vim remaps
let g:jupyter_mapkeys = 0

" Connect to kernel
nnoremap <silent><leader>jc :JupyterConnect<CR>

" Add cell
nnoremap <silent><leader>ja o# %%<Esc>o<Esc>

" Send cell to kernel
nnoremap <silent><leader><CR> :JupyterSendCell<CR>
vnoremap <silent><leader><CR> :JupyterSendRange<CR>

" " Send a selection of lines
" vnoremap <silent><leader><CR> :JupyterRunVisual<CR>

" " Update shell
" nnoremap <silent><leader>ju :JupyterUpdateShell<CR>

" Change to directory of current file
nnoremap <silent><leader>jd :JupyterCd %:p:h<CR>

" Debugging maps
nnoremap <silent><localleader>jb :PythonSetBreak<CR>

" Commenting line
nnoremap <silent><leader>c :Commentary<CR>
vnoremap <silent><leader>c :Commentary<CR>


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup thales
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
