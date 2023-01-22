-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    use('folke/zen-mode.nvim')
    use('github/copilot.vim')
    use('eandrju/cellular-automaton.nvim')

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use({
        "themercorp/themer.lua",
        config = function()
	      require("themer").setup({
	          colorscheme = "rose_pine",
	          styles = {
	            	["function"] = { style = 'italic' },
	             	functionbuiltin = { style = 'italic' },
	             	variable = { style = 'italic' },
	              	variableBuiltIn = { style = 'italic' },
	            	parameter  = { style = 'italic' },
	          },
	      })
        end
    })

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use('yianwillis/vimcdoc')       --vimcdoc
    use('ThePrimeagen/vim-be-good') --vim game
    use('ap/vim-css-color')         --css color
    use('rust-lang/rust.vim')       -- rust vim integration
    use('tpope/vim-speeddating')    -- ctrl+a and ctrl+x on dates
    use('Vonr/align.nvim')          -- align line content
    use('chaoren/vim-wordmotion')   -- better word motions through long strings
    use('lewis6991/gitsigns.nvim')  -- alternative airblade/vim-gitgutter
    use('lukas-reineke/indent-blankline.nvim')

end)
