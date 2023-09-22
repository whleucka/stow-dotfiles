return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      on_highlights = function(hl, c)
        hl.DiagnosticErrorVirtualText = {
          bg = c.none,
          fg = c.error,
        }
      end,
      integrations = {
        which_key = true,
        neotree = true,
        notify = true,
        noice = true,
        mason = true,
      },
      transparent_background = true,
    })
    vim.cmd.colorscheme 'catppuccin-frappe'
  end
}
