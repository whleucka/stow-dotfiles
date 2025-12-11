local startup_ms = nil

-- Compute startup time
if vim.g.__nvim_start_time then
  startup_ms = (vim.loop.hrtime() - vim.g.__nvim_start_time) / 1e6
else
  startup_ms = 0
end

return {
  theme = 'hyper',
  config = {
    project = {
      enable = true,
      action = function(path)
        require('fff').find_files_in_dir(path)
      end,
    },
    week_header = {
      enable = true,
    },
    packages = { enable = false },
    shortcut = {
      {
        desc = 'New',
        group = 'Label',
        action = ':enew',
        key = 'n',
      },
      {
        desc = 'Oil',
        group = 'Label',
        action = ':Oil',
        key = 'o',
      },
      {
        desc = 'Files',
        group = 'Label',
        action = function()
          require('fff').find_files()
        end,
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
          local path = vim.fn.stdpath('config')
          require('fff').find_files_in_dir(path)
        end,
        key = 'c',
      },
      {
        desc = 'Quit',
        group = 'Number',
        action = function()
          vim.cmd [[quit]]
        end,
        key = 'q',
      },
    },
    footer = {
      "",
      "With great power comes great responsibility",
      "",
      string.format("⚡ Startup time: %.2f ms", startup_ms)
    }
  }
}
