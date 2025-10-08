vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
})

local config = require("config.treesitter")
require("nvim-treesitter.configs").setup(config)

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.cfml = {
  install_info = {
    url = "https://github.com/cfmleditor/tree-sitter-cfml",
    files = {"cfml/src/parser.c"},
    branch = "master",
  },
  filetype = "cfml",
}
