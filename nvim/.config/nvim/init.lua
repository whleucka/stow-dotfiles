-- easy-i3-neovim-nav
vim.cmd[[call serverstart(tempname())]]
vim.cmd[[let &titlestring="nvim %F -- [" . v:servername . "]"]]
vim.cmd[[set title]]

require("config.options")
require("config.keymaps")

require("core.plugins").setup()
require("core.lsp")

require("config.autocmds")
