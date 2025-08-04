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

-- Auto-resize splits
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup('auto-resize-splits', { clear = true }),
  command = "tabdo wincmd ="
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

-- LSP completion
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-completion', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})
