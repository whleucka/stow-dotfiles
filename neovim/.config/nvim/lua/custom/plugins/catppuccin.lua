return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        neotree = true
      },
      transparent_background = true
    })
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end
}
