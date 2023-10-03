return {
  "braxtons12/blame_line.nvim",
  config = function()
    require("blame_line").setup {
      template = "<commit-short> • <author> • <author-time> • <summary>",
    }
    require("blame_line").disable()
  end
}
