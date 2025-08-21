local explorer = require("lib.explorer")
local opts = { noremap = true, silent = true }
local gitsigns = require('gitsigns')

-- Essentials
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>", opts)
vim.keymap.set("n", "q", "<nop>", opts)
vim.keymap.set("n", "<leader>q", ":quit<CR>", opts)
vim.keymap.set("n", "<leader>w", ":write<CR>", opts)
vim.keymap.set("n", "<esc>", ":noh<CR>", opts)
vim.keymap.set("i", "jk", "<esc>", opts)
vim.keymap.set("i", "kj", "<esc>", opts)

-- Open config
vim.keymap.set("n", "<C-Enter>", function()
  vim.cmd("edit " .. vim.fn.stdpath("config"))
end, opts)

-- Files
vim.keymap.set("n", "<leader>o", ":Oil<CR>", opts)

-- Indent selected lines
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Splits
vim.keymap.set("n", "<leader>-", ":split<CR>", opts)
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>", opts)

--  Moving between splits
vim.keymap.set("n", "<A-h>", "<C-w>h", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l", opts)
-- Resize splits
vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-j>", ":resize -2<CR>")
vim.keymap.set("n", "<C-k>", ":resize +2<CR>")
vim.keymap.set("n", "<C-=>", "<C-w>=<CR>")

-- Find files / grep
vim.keymap.set("n", "<leader>f", function()
  explorer.find_files()
end, opts)
vim.keymap.set("n", "<leader>s", function()
  explorer.grep_files()
end, opts)

-- Git
vim.keymap.set('n', '<leader>gs', ':Git<CR>', opts)           -- Git status
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>', opts)  -- Git diff in split
vim.keymap.set('n', '<leader>gP', ':Git push<CR>', opts)      -- Git push
vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>', opts)     -- Git fetch
vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', opts)      -- Git pull
vim.keymap.set('n', '<leader>gl', ':0Gclog<CR>', opts)        -- Git log for current file
vim.keymap.set("n", "<leader>ga", ":Git add %<CR>", opts)     -- Stage current file
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", opts)     -- Git blame current file
vim.keymap.set("n", "<leader>gc", ":Git commit -v<CR>", opts) -- Git commit
vim.keymap.set("n", "<leader>gco", ":Git checkout ", opts)    -- Git checkout
vim.keymap.set("n", "<leader>gm", ":Git merge ", opts)        -- Git merge
vim.keymap.set("n", "<leader>gr", ":Gdiffsplit!<CR>", opts)   -- Resolve conflicts with :Gdiffsplit
vim.keymap.set("n", "<leader>goc", ":diffget //2<CR>", opts)  -- Take OUR changes
vim.keymap.set("n", "<leader>gtc", ":diffget //3<CR>", opts)  -- Take THIER changes
vim.keymap.set("n", "<leader>gq", ":diffoff!<CR>", opts)      -- Quit diff mode

-- Hunks
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gitsigns.nav_hunk('next')
  end
end)
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    gitsigns.nav_hunk('prev')
  end
end)
vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk)
vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline)
vim.keymap.set('n', '<leader>hb', function()
  gitsigns.blame_line({ full = true })
end)
vim.keymap.set({'o', 'x'}, 'ih', gitsigns.select_hunk)



-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)         -- Go to declaration
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)      -- Go to implementation
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- Go to references
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Hover docs
vim.keymap.set('n', '<C-,>', vim.lsp.buf.signature_help, opts)   -- Signature help
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename symbol
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
vim.keymap.set('n', '<leader>cf', function()
  vim.lsp.buf.format { async = true }                            -- Format file
end, opts)
