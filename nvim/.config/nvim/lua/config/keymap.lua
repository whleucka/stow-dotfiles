local explorer = require("lib.explorer")

-- Essentials
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>x", ":update<CR> :source<CR>")

-- Splits
vim.keymap.set("n", "<leader>-", ":split<CR>")
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>")

-- Find files / grep
vim.keymap.set("n", "<leader>f", function()
  explorer.find_files()
end)
vim.keymap.set("n", "<leader>g", function()
  explorer.grep_files()
end)
