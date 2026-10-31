return {

    {
        'rose-pine/neovim',
        name = 'rose-pine',
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

    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
    },

    {
        'eandrju/cellular-automaton.nvim',
        cmd = 'CellularAutomaton',
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
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

    'yianwillis/vimcdoc',                  --vimcdoc

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

    -- Go development
    {
        'ray-x/go.nvim',
        dependencies = { 'ray-x/guihua.lua' },
        config = function()
            require('go').setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()'
    },
    'ray-x/guihua.lua', -- go.nvim dependency
}
