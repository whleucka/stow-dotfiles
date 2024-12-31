-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "q", "<nop>", { desc = "Nothing" })

-- Exit insert mode
map("i", "jk", "<C-c>", { desc = "Exit insert mode" })
map("i", "kj", "<C-c>", { desc = "Exit insert mode" })

-- Focus
local focusmap = function(direction)
    map("n", "<C-" .. direction .. ">", function()
        require("focus").split_command(direction)
    end, { desc = string.format("Create or move to split (%s)", direction) })
end

focusmap("h")
focusmap("j")
focusmap("k")
focusmap("l")

map("n", "<c-p>", function() require('fzf-lua').git_files() end, { desc = "Open recent files" })

map("n", "<leader>ws", "<nop>")
map("n", "<leader>wv", "<nop>")
