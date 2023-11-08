return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  event = "VimEnter",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      on_highlights = function(hl, c)
        hl.DiagnosticErrorVirtualText = {
          bg = c.none,
          fg = c.error,
        }
      end,
      floating_border = "on",
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          FloatBorder = { fg = colors.blue },
          LineNr = { fg = "#888888" },
          Pmenu = { fg = colors.blue },
          PmenuSel = { bg = colors.surface0, fg = colors.blue },
        }
      end,
    })
    vim.cmd.colorscheme 'catppuccin-mocha'
  end
}
