---@diagnostic disable: missing-fields
return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "BufReadPost",
  version = "*",   -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup({
      --  insert = "<C-g>s",
      --  insert_line = "<C-g>S",
      --  normal = "ys",
      --  normal_cur = "yss",
      --  normal_line = "yS",
      --  normal_cur_line = "ySS",
      --  visual = "S",
      --  visual_line = "gS",
      --  delete = "ds",
      --  change = "cs",
      --  change_line = "cS",
    })
  end
}
