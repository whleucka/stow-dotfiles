return {
  "braxtons12/blame_line.nvim",
  lazy = true,
  event = "BufReadPre",
  config = function()
    require("blame_line").setup {
      template = "<commit-short> • <author> • <author-time> • <summary>",
    }
    require("blame_line").disable()
  end
}
