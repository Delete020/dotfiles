return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

    -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'saghen/blink.cmp'},
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add blink.cmp capabilities settings to lspconfig
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('blink.cmp').get_lsp_capabilities()
      )

      require('mason-lspconfig').setup({
        automatic_enable = true,
        ensure_installed = {
          -- Language Servers
          'lua_ls',
          'rust_analyzer',
          'pyright',
          'clangd',
          'gopls',
          'html',
          'cssls',
          'jsonls',
          'yamlls',
          'marksman',
          'bashls',
          'sqlls',
          'taplo', -- TOML
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          
          -- Go language server configuration
          gopls = function()
            require('lspconfig').gopls.setup({
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                  usePlaceholders = true,
                  completeUnimported = true,
                  buildFlags = {"-tags", "integration"},
                  experimentalPostfixCompletions = true,
                  hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                  },
                },
              },
              on_attach = function(client, bufnr)
                -- Enable inlay hints if available
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
              end,
            })
          end,
        }
      })
    end
  },
}
