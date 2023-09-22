return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      on_highlights = function(hl, c)
        hl.DiagnosticErrorVirtualText = {
          bg = c.none,
          fg = c.error, -- unsure if overriding fg to the same colors as before is necessary
        }
        -- repeat for other stuff
      end,
      integrations = {
        which_key = true,
        neotree = true,
        notify = true,
        noice = true,
        mason = true,

      },
      transparent_background = true
    })
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end
}
