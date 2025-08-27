local gitsigns = require("gitsigns")
local flash = require("flash")
local wk = require("which-key")
local fzf = require("fzf-lua")

wk.add({
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Help",
  },
  { "<leader>o", ":Oil<CR>", desc = "Oil" },
  {
    "<leader>f",
    group = "Find",
    { "<leader>ff", fzf.files,     desc = "Files" },
    { "<leader>fh", fzf.helptags,  desc = "Help" },
    { "<leader>fc", fzf.commands,  desc = "Commands" },
    { "<leader>fm", fzf.manpages,  desc = "Manpages" },
    { "<leader>fk", fzf.keymaps,   desc = "Keymap" },
    { "<leader>fg", fzf.git_files, desc = "Git files" },
    { "<leader>fo", fzf.oldfiles,  desc = "Opened files" },
    { "<leader>fb", fzf.buffers,   desc = "Buffers" },
    { "<leader>ft", fzf.tabs,      desc = "Tabs" },
    { "<leader>f/", fzf.blines,    desc = "Lines" },
    { "<leader>fq", fzf.quickfix,  desc = "Quickfix" },
    { "<leader>fl", fzf.loclist,   desc = "Location list" },
  },
  {
    "<leader>s",
    group = "Search",
    { "<leader>sg", fzf.grep,      desc = "Grep" },
    { "<leader>s/", fzf.live_grep, desc = "Live grep" },
  },
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
    "<leader>g",
    group = "Git (fugitive)",
    { "<leader>gs", ":Git<CR>",           desc = "Status" },
    { "<leader>gb", ":Git blame<CR>",     desc = "Blame" },
    { "<leader>gl", ":0Gclog<CR>",        desc = "Log" },
    { "<leader>gO", ":Git checkout ",     desc = "Checkout" },
    { "<leader>gP", ":Git push<CR>",      desc = "Push" },
    { "<leader>gp", ":Git pull<CR>",      desc = "Pull" },
    { "<leader>gf", ":Git fetch<CR>",     desc = "Fetch" },
    { "<leader>ga", ":Git add %<CR>",     desc = "Add current file" },
    { "<leader>gC", ":Git commit -v<CR>", desc = "Commit" },
    { "<leader>gm", ":Git merge ",        desc = "Merge" },
    { "<leader>gd", ":Gvdiffsplit!<CR>",  desc = "Diff" },
    { "<leader>gD", ":diffoff!<CR>",      desc = "Quit diff mode" },
    {
      "<leader>gh",
      group = "Hunk",
      { "<leader>ghs", gitsigns.stage_hunk,          desc = "Stage" },
      { "<leader>ghr", gitsigns.reset_hunk,          desc = "Reset" },
      { "<leader>ghp", gitsigns.preview_hunk,        desc = "Preview" },
      { "<leader>ghi", gitsigns.preview_hunk_inline, desc = "Preview inline" },
      {
        "<leader>ghb",
        function()
          gitsigns.blame_line({ full = true })
        end,
        desc = "Blame line"
      },
    }
  },
  {
    { "q",               "<nop>" },
    { "<leader><space>", ":write<CR>",                desc = "Save", },
    { "<F5>",            ":update<CR> :source<CR>",   desc = "Source file", },
    { "<C-h>",           "<C-w>h",                    desc = "Move to left window" },
    { "<C-j>",           "<C-w>j",                    desc = "Move to bottom window" },
    { "<C-k>",           "<C-w>k",                    desc = "Move to top window" },
    { "<C-l>",           "<C-w>l",                    desc = "Move to right window" },
    { "<A-h>",           ":vertical resize -2<CR>",   desc = "Decrease window width" },
    { "<A-l>",           ":vertical resize +2<CR>",   desc = "Increase window width" },
    { "<A-j>",           ":resize -2<CR>",            desc = "Decrease window height" },
    { "<A-k>",           ":resize +2<CR>",            desc = "Increase window height" },
    { "<A-=>",           "<C-w>=<CR>",                desc = "Automatically resize windows" },
    { "gd",              vim.lsp.buf.definition,      desc = "Go to definition" },
    { "gD",              vim.lsp.buf.declaration,     desc = "Go to declaration" },
    { "gi",              vim.lsp.buf.implementation,  desc = "Go to implementation" },
    { "gr",              vim.lsp.buf.references,      desc = "Go to references" },
    { "gT",              vim.lsp.buf.type_definition, desc = "Go to type definition" },
    { "g0",              vim.lsp.buf.document_symbol, desc = "Go to table of contents" },
    { "<C-s>",           vim.lsp.buf.signature_help,  desc = "Signature help" },
  },
  {
    mode = "i",
    { "jk", "<esc>" },
    { "kj", "<esc>" }
  },
  {
    mode = "v",
    { "<", "<gv",              desc = "Indent selected <" },
    { ">", ">gv",              desc = "Indent selected >" },
    { "J", ":m '>+1<CR>gv=gv", desc = "Move selected line down" },
    { "K", ":m '<-2<CR>gv=gv", desc = "Move selected line up" },
  },
  {
    mode = "o",
    {
      "r", flash.remote, desc = "Remote flash",
    },
  },
  {
    mode = { "n", "x", "o" },
    { "s", flash.jump,       desc = "Flash" },
    { "S", flash.treesitter, desc = "Flash treesitter" },
  },
  {
    mode = { "o", "x" },
    { "R", flash.treesitter_search, desc = "Treesitter search" },
  },
})
