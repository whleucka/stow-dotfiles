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

map("n", "<leader>ws", "<ESC>")
map("n", "<leader>wv", "<ESC>")

map("n", "<leader>w", "<cmd>update<cr>", { desc = "Update (save) buffer" })

map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Neogit" })

map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run the nearest test" })
map("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop the nearest test" })
map("n", "<leader>ta", function() require("neotest").run.attach() end, { desc = "Attach the nearest test" })
map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run the current file" })
map("n", "<leader>tt", function() require("neotest").run.run({ suite = true }) end, { desc = "Run the test suite" })
map("n", "<leader>to", function() require("neotest").output_panel.toggle() end, { desc = "Toggle the output panel" })
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle the test summary" })
