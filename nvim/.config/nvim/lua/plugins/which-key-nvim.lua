vim.pack.add({
  {
    src = "https://github.com/folke/which-key.nvim",
  }
})

local wk = require("which-key")
wk.add({
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Help",
  }
})
