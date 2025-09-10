local wk = require("which-key")
local folds_enabled = vim.opt.foldenable

wk.add({
  {
    "<leader>c",
    group = "Code",
    {
      "<leader>ca",
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "Action"
    },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = "Format"
    },
    {
      "<leader>cr",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "Rename symbol"
    },
  },
  {
    "<leader>u",
    group = "UI",
    { "<leader>un", ":set number!<CR>",         desc = "Toggle line numbers" },
    { "<leader>ur", ":set relativenumber!<CR>", desc = "Toggle relative numbers" },
    { "<leader>uw", ":set wrap!<CR>",           desc = "Toggle line wrap" },
    { "<leader>us", ":set spell!<CR>",          desc = "Toggle spell check" },
    { "<leader>ul", ":set list!<CR>",           desc = "Toggle invisible characters" },
    { "<leader>uh", ":set hlsearch!<CR>",       desc = "Toggle search highlight" },
    { "<leader>ui", ":set cursorline!<CR>",     desc = "Toggle cursorline" },
    {
      "<leader>uc",
      function()
        if vim.wo.colorcolumn == "" then
          vim.wo.colorcolumn = "80"
        else
          vim.wo.colorcolumn = ""
        end
      end,
      desc = "Toggle colorcolumn"
    },
    {
      "<leader>ud",
      function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end,
      desc = "Toggle diagnostics"
    },
    {
      "<leader>ub",
      function()
        if vim.o.background == "dark" then
          vim.o.background = "light"
        else
          vim.o.background = "dark"
        end
      end,
      desc = "Toggle light/dark background"
    },
    {
      "<leader>ut",
      function()
        local config = require("config.catppuccin")
        config.transparent_background = not config.transparent_background
        require("catppuccin").setup(config)
        vim.cmd.colorscheme("catppuccin")
      end,
      desc = "Toggle transparency"
    },
    {
      "<leader>uf",
      function()
        folds_enabled = not folds_enabled
        if folds_enabled then
          vim.wo.foldenable = false
        else
          vim.wo.foldenable = true
        end
      end,
      desc = "Toggle folds"
    },
  },
  {
    "<leader>w",
    group = "Window",
    { "<leader>wn", ":new<CR>",    desc = "New" },
    { "<leader>wq", ":q<CR>",      desc = "Close" },
    { "<leader>wQ", ":qall<CR>",   desc = "Close all" },
    { "<leader>ws", ":split<CR>",  desc = "Split" },
    { "<leader>wv", ":vsplit<CR>", desc = "Vertical split" },
  },
  {
    "<leader>t",
    group = "Tab",
    { "<leader>tn", ":tabnew<CR>",   desc = "New" },
    { "<leader>tn", ":tabnext<CR>",  desc = "Next" },
    { "<leader>tp", ":tabprev<CR>",  desc = "Prev" },
    { "<leader>tf", ":tabfirst<CR>", desc = "First" },
    { "<leader>tl", ":tablast<CR>",  desc = "Last" },
  },
  {
    "<leader>b",
    group = "Buffer",
    { "<leader>bb", ":enew<CR>",   desc = "New" },
    { "<leader>bq", ":bd<CR>",     desc = "Close" },
    { "<leader>bn", ":bnext<CR>",  desc = "Next" },
    { "<leader>bp", ":bprev<CR>",  desc = "Prev" },
    { "<leader>bf", ":bfirst<CR>", desc = "First" },
    { "<leader>bl", ":blast<CR>",  desc = "Last" },
  },
  {
    { "q",          "<nop>" },
    { "<esc><esc>", ":noh<CR>" },
    { "<leader>q", function()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      if #bufs > 1 then
        vim.cmd("bd")
      else
        vim.cmd("Dashboard")
      end
    end, desc = "Close buffer" },
    { "<leader>Q", ":q<CR>", desc = "Close Neovim" },
    { "H", ":bprev<CR>", desc = "Previous Buffer" },
    { "L", ":bnext<CR>", desc = "Previous Buffer" },
    { "<C-s>",      ":write<CR>",                desc = "Save", },
    { "<F5>",       ":update<CR> :source<CR>",   desc = "Source file", },
    { "<C-h>",      "<C-w>h",                    desc = "Move to left window" },
    { "<C-j>",      "<C-w>j",                    desc = "Move to bottom window" },
    { "<C-k>",      "<C-w>k",                    desc = "Move to top window" },
    { "<C-l>",      "<C-w>l",                    desc = "Move to right window" },
    { "<A-h>",      ":vertical resize -2<CR>",   desc = "Decrease window width" },
    { "<A-l>",      ":vertical resize +2<CR>",   desc = "Increase window width" },
    { "<A-j>",      ":resize -2<CR>",            desc = "Decrease window height" },
    { "<A-k>",      ":resize +2<CR>",            desc = "Increase window height" },
    { "<A-=>",      "<C-w>=<CR>",                desc = "Automatically resize windows" },
    { "gd",         vim.lsp.buf.definition,      desc = "Go to definition" },
    { "gD",         vim.lsp.buf.declaration,     desc = "Go to declaration" },
    { "gi",         vim.lsp.buf.implementation,  desc = "Go to implementation" },
    { "gr",         vim.lsp.buf.references,      desc = "Go to references" },
    { "gT",         vim.lsp.buf.type_definition, desc = "Go to type definition" },
    { "g0",         vim.lsp.buf.document_symbol, desc = "Go to table of contents" },
    { "gs",         vim.lsp.buf.signature_help,  desc = "Signature help" },
    { "]t",         ":tabnext<CR>",              desc = "Tab next" },
    { "[t",         ":tabprev<CR>",              desc = "Tab prev" },
  },
  {
    mode = "i",
    { "<C-s>", "<C-\\><C-o>:write<CR>", desc = "Save", },
    { "jk",    "<esc>" },
    { "kj",    "<esc>" },
  },
  {
    mode = "v",
    { "<", "<gv",              desc = "Indent selected <" },
    { ">", ">gv",              desc = "Indent selected >" },
    { "J", ":m '>+1<CR>gv=gv", desc = "Move selected line down" },
    { "K", ":m '<-2<CR>gv=gv", desc = "Move selected line up" },
  },
})
