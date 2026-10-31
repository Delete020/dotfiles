return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = 'rounded',
        scrollbar = true,
        draw = {
          treesitter = { 'lsp' }
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        update_delay_ms = 50,
        window = { border = 'rounded' }
      },
      ghost_text = { enabled = true }
    },

    signature = {
      enabled = true,
      window = { border = 'rounded' }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { fallbacks = { 'buffer' } },
        buffer = { max_items = 4 },
        snippets = { score_offset = -3 }
      }
    },

  },
  opts_extend = { "sources.default" }
}
