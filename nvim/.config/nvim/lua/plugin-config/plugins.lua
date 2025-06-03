return {

    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },

    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
        keys = {
            ['<leader>c'] = { group = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>d'] = { group = '[D]ocument', _ = 'which_key_ignore' },
            ['<leader>r'] = { group = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { group = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>w'] = { group = '[W]orkspace', _ = 'which_key_ignore' },
        },
    },

    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    'folke/zen-mode.nvim',
    'github/copilot.vim',
    'eandrju/cellular-automaton.nvim',

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        --tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
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
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    'lewis6991/impatient.nvim',
    'yianwillis/vimcdoc',                  --vimcdoc
    'ThePrimeagen/vim-be-good',            --vim game
    'ap/vim-css-color',                    --css color
    'rust-lang/rust.vim',                  -- rust vim integration
    'tpope/vim-speeddating',               -- ctrl+a and ctrl+x on dates
    'Vonr/align.nvim',                     -- align line content
    'chaoren/vim-wordmotion',              -- better word motions through long strings
    'lewis6991/gitsigns.nvim',             -- alternative airblade/vim-gitgutter
    'lukas-reineke/indent-blankline.nvim', -- display blankline
    'lambdalisue/suda.vim',                -- sudo privilege save file
    'max397574/better-escape.nvim',        -- jj to escape insert mode
    'tpope/vim-sleuth',                    -- Detect tabstop and shiftwidth automatically
    'stevearc/conform.nvim',
}
