return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'arkav/lualine-lsp-progress',
  },
  config = function()
    require'lualine'.setup{
      sections = {
        lualine_c = {
          'lsp_progress'
        }
      }
    }
  end,
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'catppuccin',
      component_separators = '|',
      section_separators = '',
    },
  },
}
