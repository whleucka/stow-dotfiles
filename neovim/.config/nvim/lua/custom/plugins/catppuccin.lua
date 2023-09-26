return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
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
        cmp = true,
        which_key = true,
        neotree = true,
        notify = true,
        noice = true,
        mason = true,
      },
      transparent_background = true,
    })
    vim.cmd.colorscheme 'catppuccin-mocha'
  end
}
