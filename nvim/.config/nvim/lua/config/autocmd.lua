-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 150, on_visual = true })
  end,
})

-- Treesitter update
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
    callback = function(event)
        if event.data.kind == 'update' then
            vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, 'TSUpdate')
            if ok then
                vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
            else
                vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
            end
        end
    end,
})

-- Restore last cursor pos
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup('restore-cursor-pos', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local pos = vim.api.nvim_buf_get_mark(buf, '"')
    local lines = vim.api.nvim_buf_line_count(buf)
    if pos[1] > 0 and pos[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})

-- Auto reload file if changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = vim.api.nvim_create_augroup('auto-reload-file', { clear = true }),
  command = "checktime"
})

-- Enable spellcheck
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('enable-spellcheck', { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Clear search
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup('clear-search-cursor-move', { clear = true }),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.mode() == "n" then
      vim.cmd("nohlsearch")
    end
  end,
})

-- Plugins
require("plugins.which-key-nvim")

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup('lazy-vim-enter', { clear = true }),
  callback = function()
    require("plugins.dashboard-nvim")
    require("plugins.bufferline-nvim")
    require("plugins.lualine-nvim")
    require('plugins.vim-repeat')
    require("plugins.oil-nvim")
    require('plugins.vim-fugitive')
    require('plugins.fzf-lua')
  end
})

vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  group = vim.api.nvim_create_augroup('lazy-buf-read', { clear = true }),
  callback = function()
    require("plugins.nvim-treesitter")
    require('plugins.flash-nvim')
    require("plugins.gitsigns")
  end
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup('lazy-insert-enter', { clear = true }),
  callback = function()
    require("plugins.blink-cmp")
    require("plugins.luasnip")
  end
})
