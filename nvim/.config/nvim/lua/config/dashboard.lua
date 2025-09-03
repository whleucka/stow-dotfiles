return {
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    packages = { enable = false },
    shortcut = {
      {
        desc = 'Files',
        group = 'Label',
        action = 'FzfLua files',
        key = 'f',
      },
      {
        desc = 'Update Plugins',
        group = 'Label',
        action = function()
          vim.pack.update()
        end,
        key = 'u',
      },
      {
        desc = 'Config',
        group = 'Label',
        action = function()
          require('fzf-lua').files({
            cwd = vim.fn.stdpath('config')
          })
        end,
        key = 'c',
      },
      {
        desc = 'Quit',
        group = 'Number',
        action = function()
          vim.cmd[[quit]]
        end,
        key = 'q',
      },
    },
    footer = {
      "",
      "With great power comes great responsibility"
    }
  }
}
