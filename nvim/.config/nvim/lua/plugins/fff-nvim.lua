vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('fff-pack-changed', { clear = true }),
  callback = function(event)
    if event.data.updated then
      require('fff.download').download_or_build_binary()
    end
  end,
})

-- the plugin will automatically lazy load
vim.g.fff = {
  lazy_sync = true, -- start syncing only when the picker is open
  debug = {
    enabled = true,
    show_scores = true,
  },
}

local wk = require("which-key")
wk.add({
  {
    "<leader>f",
    group = "Find",
    { "<leader>ff", function() require('fff').find_files() end, desc = "Files" },
    {
      "<leader>fc",
      function()
        local path = vim.fn.stdpath('config')
        require('fff').find_files_in_dir(path)
      end,
      desc = "Config"
    },
    { "<leader>fg", function() require('fff').find_in_git_root() end, desc = "Git files" },
  },
})
