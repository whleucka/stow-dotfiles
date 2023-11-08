return {
  'nmac427/guess-indent.nvim',
  event = { "BufReadPost", "BufNewFile" },
  config = function() require('guess-indent').setup {} end,
}
