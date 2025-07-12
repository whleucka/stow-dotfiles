return {
  url = "https://github.com/neovim/nvim-lspconfig",
  name = "nvim-lspconfig",
  dependencies = {
    {
      url = "https://github.com/Saghen/blink.cmp",
      name = "blink.cmp",
      build = "cargo build --release",
      setup = function()
        local blink = require("blink.cmp")
        local lspconfig = require('lspconfig')

        blink.setup({
          -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
          -- 'super-tab' for mappings similar to vscode (tab to accept)
          -- 'enter' for enter to accept
          -- 'none' for no mappings
          --
          -- All presets have the following mappings:
          -- C-space: Open menu or open docs if already open
          -- C-n/C-p or Up/Down: Select next/previous item
          -- C-e: Hide menu
          -- C-k: Toggle signature help (if signature.enabled = true)
          --
          -- See :h blink-cmp-config-keymap for defining your own keymap
          keymap = { preset = 'super-tab' },

          appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
          },

          -- (Default) Only show the documentation popup when manually triggered
          completion = { documentation = { auto_show = true } },

          -- Default list of enabled providers defined so that you can extend it
          -- elsewhere in your config, without redefining it, due to `opts_extend`
          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
          },

          -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
          -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
          -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
          --
          -- See the fuzzy documentation for more information
          fuzzy = { implementation = "prefer_rust_with_warning" }
        })

        local capabilities = blink.get_lsp_capabilities()
        for _, server in ipairs({ "intelephense", "bashls", "lua_ls" }) do
          lspconfig[server].setup({ capabilities = capabilities })
        end
      end
    }
  },
  setup = function()
    vim.lsp.enable("intelephense")
    vim.lsp.enable("bashls")
    vim.lsp.enable("lua_ls")
  end
}
