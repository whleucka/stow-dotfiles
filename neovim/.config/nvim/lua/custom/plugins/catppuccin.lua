return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    transparent_background = true,
    styles = {
      keywords = { "bold" },
      functions = { "italic" },
    },
    integrations = {
      mason = true,
      neotree = true,
      neotest = true,
      which_key = true,
      neogit = false,
      nvimtree = false,
      dashboard = false,
      rainbow_delimiters = false,
      dap = { enabled = true, enable_ui = true },
      telescope = { enabled = true, style = nil },
    },
  },
  config = function()
    vim.cmd.colorscheme 'catppuccin'
  end
}
