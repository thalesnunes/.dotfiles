local install_path = vim.fn.stdpath('data') ..
                            '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        '--depth', '1', install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' ..
                            vim.o.runtimepath
end

-- autocompile on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)

    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- Themeing
    use {
        'Mofiqul/dracula.nvim',
        config = function() require('plugins.dracula') end
    }

    -- Status line
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.lualine') end,
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        config = function() require('plugins.bufferline') end,
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }

    -- Indent lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('plugins.indentline') end,
    }

    -- File tree
    use {
        'kevinhwang91/rnvimr',
        config = function() require('plugins.rnvimr') end,
    }

    -- Adding and removing pairs
    use { 'machakann/vim-sandwich' }

    -- Auto bracket pairs
    use {
        'windwp/nvim-autopairs',
        config = function() require('plugins.autopairs') end,
    }

    -- Commenter
    use {
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end,
    }

    -- Highlighter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end,
    }

    -- Rainbow pairs
    use {
        'p00f/nvim-ts-rainbow',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
    }

    -- LSP plugin
    use {
        'neovim/nvim-lspconfig',
        after = 'nvim-treesitter',
        config = function() require('plugins.lsp') end,
    }

    -- Code auto-completion with nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        after = 'nvim-lspconfig',
        config = function() require('plugins.cmp') end,
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
    }

    -- Snippets plugin
    use {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets',
        },
    }

    -- Toggle floating terminals with tools
    use {
        'akinsho/toggleterm.nvim',
        keys = {
            '<leader>t',
            '<leader>g',
        },
        config = function() require('plugins.toggleterm') end,
    }

    -- Plenary
    use { 'nvim-lua/plenary.nvim' }

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
        event = 'VimEnter',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    -- Fzf support
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    -- Clipboard manager
    use {
        'AckslD/nvim-neoclip.lua',
        after = 'telescope.nvim',
        config = function() require('plugins.neoclip') end,
    }

    -- Gitsigns
    use {
        'lewis6991/gitsigns.nvim',
        after = 'telescope.nvim',
        config = function() require('plugins.gitsigns') end,
    }

    -- Manage undo tree easily
    use {
        'mbbill/undotree',
        keys = {
            '<leader>u',
        },
        config = function() require('plugins.undotree') end,
    }

    -- Color code highlighting
    use {
        'norcalli/nvim-colorizer.lua',
        cmd = {
            'ColorizerAttachToBuffer',
            'ColorizerToggle',
        },
        config = function() require('plugins.colorizer') end,
    }

    -- Python code formatter
    use {
        'ambv/black',
        cmd = {
            'Black',
        },
    }

    -- Jupyter plugin
    use {
        'jupyter-vim/jupyter-vim',
        keys = {
            '<leader>jc',
            '<leader>ja',
            '<leader>jr',
        },
        config = function() require('plugins.jupyter') end,
    }

    -- i3 highlighting
    use {
        'mboughaba/i3config.vim',
        ft = 'i3config',
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end

end)
