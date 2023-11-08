return {
  'nmac427/guess-indent.nvim',
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function() require('guess-indent').setup {} end,
}
