-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For clipboard
vim.cmd[[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title
]]

-- Start
require("whleucka.core")
require("whleucka.lazy")
require("whleucka.autocmd")

-- Theme
vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme "nvimgelion"
--vim.cmd("highlight Normal guibg=none")
--vim.cmd("highlight NonText guibg=none")
--vim.cmd("highlight LineNr guibg=none")
--vim.cmd("highlight Folded guibg=none")
--vim.cmd("highlight EndOfBuffer guibg=none")
