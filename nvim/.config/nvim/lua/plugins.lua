local install_path = V.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'

if V.fn.empty(V.fn.glob(install_path)) > 0 then
    V.fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    V.cmd 'packadd packer.nvim'
end

-- autocompile on save
V.cmd([[
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
        'dracula/vim',
        as = 'dracula',
    }

    -- Status line
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.lualine') end,
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }

    -- File tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugins.nvimtree') end,
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
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
        'terrortylor/nvim-comment',
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

end)
