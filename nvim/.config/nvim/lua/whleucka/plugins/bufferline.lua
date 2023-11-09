return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        separator_style = 'thin',
        offsets = {
          {
            filetype = "neo-tree",
            text = "🇺🇦~*! Слава Україні !*~ 🇨🇦",
            separator = true,
            text_align = "center"
          }
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
