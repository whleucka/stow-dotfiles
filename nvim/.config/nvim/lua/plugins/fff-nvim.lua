vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup('fff-pack-changed', { clear = true }),
  callback = function(event)
    local data = event.data or {}

    if data.updated or data.installed then
      -- Reload module in case pack just pulled new code
      package.loaded["fff.download"] = nil
      local ok, mod = pcall(require, "fff.download")
      if ok then
        mod.download_or_build_binary()
      else
        print("Failed to load fff.download:", mod)
      end
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
