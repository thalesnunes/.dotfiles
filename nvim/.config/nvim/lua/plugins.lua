local install_path = V.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'

if V.fn.empty(V.fn.glob(install_path)) > 0 then
    V.fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    V.cmd [[packadd packer.nvim]]
end

V.cmd [[packadd packer.nvim]]

-- autocompile on save
V.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- Auto bracket pairs and surround
    use { 'jiangmiao/auto-pairs' }
    use { 'machakann/vim-sandwich' }

    -- Commenter
    use {
        'terrortylor/nvim-comment',
        config = function() require('plugins.comment') end
    }

    -- LSP plugin
    use {
        'neovim/nvim-lspconfig',
        config = function() require('plugins.lsp') end
    }

    -- Code auto-completion with nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.cmp') end,
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path'
        }
    }

    -- Highlighter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }

    -- Git integration
    use { 'tpope/vim-fugitive' }

    -- Telescope and Harpoon, fuzzy finder and file switcher
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim'
        }
    }
    use {
        'ThePrimeagen/harpoon',
        config = function() require('plugins.harpoon') end,
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim'
        }
    }

    -- Clipboard manager
    use {
        'AckslD/nvim-neoclip.lua',
        config = function() require('plugins.neoclip') end
    }

    -- Themeing
    use { 'mboughaba/i3config.vim' }
    use {
        'dracula/vim',
        as = 'dracula'
    }
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.lualine') end,
        requires = {
            'kyazdani42/nvim-web-devicons'
        }
    }

    -- Python code formatter
    use { 'ambv/black' }

    -- Jupyter plugin
    use {
        'jupyter-vim/jupyter-vim',
        ft = 'python',
        config = function() require('plugins.jupyter') end
    }
end)
