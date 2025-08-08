local explorer = require("lib.explorer")
local opts = { noremap = true, silent = true }

-- Essentials
vim.keymap.set("n", "q", "<nop>", opts)
vim.keymap.set("n", "<leader>q", ":quit<CR>", opts)
vim.keymap.set("n", "<leader>w", ":write<CR>", opts)
vim.keymap.set("n", "<leader>s", ":update<CR> :source<CR>", opts)
vim.keymap.set("n", "<esc>", ":noh<CR>", opts)
vim.keymap.set("i", "jk", "<esc>", opts)
vim.keymap.set("i", "kj", "<esc>", opts)

-- Files
vim.keymap.set("n", "<leader>o", ":Oil<CR>", opts)

-- Git
vim.keymap.set('n', '<leader>gs', ':Git<CR>', opts)

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)         -- Go to declaration
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)      -- Go to implementation
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- Go to references
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Hover docs
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)   -- Signature help
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename symbol
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
vim.keymap.set('n', '<leader>cf', function()
  vim.lsp.buf.format { async = true }                            -- Format file
end, opts)

-- Splits
vim.keymap.set("n", "<leader>-", ":split<CR>", opts)
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>", opts)

-- Find files / grep
vim.keymap.set("n", "<leader>f", function()
  explorer.find_files()
end, opts)
vim.keymap.set("n", "<leader>g", function()
  explorer.grep_files()
end, opts)
