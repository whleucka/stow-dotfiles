return {
  "nvim-neotest/neotest",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-phpunit",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-phpunit")
      },
    })
  end
}
