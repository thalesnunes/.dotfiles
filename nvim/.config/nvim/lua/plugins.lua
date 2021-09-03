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

    -- Auto bracket pairs
    use { 'jiangmiao/auto-pairs' }

    -- Adding and removing pairs
    use { 'machakann/vim-sandwich' }

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

    -- Git integration
    use {
        'TimUntersberger/neogit',
        keys = {
            '<leader>g'
        },
        config = function() require('plugins.neogit') end,
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim'
        },
    }

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
        event = 'BufRead',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
    }

    -- Clipboard manager
    use {
        'AckslD/nvim-neoclip.lua',
        after = 'telescope.nvim',
        config = function() require('plugins.neoclip') end,
    }

    -- File switcher
    use {
        'ThePrimeagen/harpoon',
        config = function() require('plugins.harpoon') end,
        after = 'nvim-neoclip.lua',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        }
    }

    -- Faster movement inside file
    use {
        'phaazon/hop.nvim',
        as = 'hop',
        keys = {
            '<leader>fd',
        },
        config = function() require('plugins.hop') end,
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
        },
        config = function() require('plugins.jupyter') end,
    }

    -- i3 highlighting
    use {
        'mboughaba/i3config.vim',
        ft = 'i3config',
    }

end)
