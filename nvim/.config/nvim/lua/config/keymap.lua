local explorer = require("lib.explorer")
local gitsigns = require("gitsigns")
local flash = require("flash")
local wk = require("which-key")

wk.add({
  { "<leader>?", function()
    require("which-key").show({ global = false })
  end, desc = "Help", },
  { "<leader>o", ":Oil<CR>", desc = "Oil (files)" },
  { "<leader>f", group = "Find",
    { "<leader>ff", explorer.find_files, desc = "Files"},
  },
  { "<leader>s", group = "Search",
    { "<leader>sg", explorer.grep_files, desc = "Grep"},
  },
  {
    "<leader>w", group = "Window",
    { "<leader>wn", ":new<CR>", desc = "New" },
    { "<leader>wq", ":q<CR>", desc = "Close" },
    { "<leader>wQ", ":qall<CR>", desc = "Close all" },
    { "<leader>ws", ":split<CR>", desc = "Split" },
    { "<leader>wv", ":vsplit<CR>", desc = "Vertical split" },
  },
  {
    "<leader>b", group = "Buffer",
    { "<leader>bb", ":enew<CR>", desc = "New" },
    { "<leader>bq", ":bd<CR>", desc = "Close" },
    { "<leader>bn", ":bnext<CR>", desc = "Next" },
    { "<leader>bp", ":bprev<CR>", desc = "Prev" },
    { "<leader>bf", ":bfirst<CR>", desc = "First" },
    { "<leader>bl", ":blast<CR>", desc = "Last" },
  },
  {
    "<leader>g", group = "Git (fugitive)",
    { "<leader>gs", ":Git<CR>", desc = "Status" },
    { "<leader>gb", ":Git blame<CR>", desc = "Blame" },
    { "<leader>gl", ":0Gclog<CR>", desc = "Log" },
    { "<leader>gO",":Git checkout ", desc = "Checkout" },
    { "<leader>gP", ":Git push<CR>", desc = "Push" },
    { "<leader>gp", ":Git pull<CR>", desc = "Pull" },
    { "<leader>gf", ":Git fetch<CR>", desc = "Fetch" },
    { "<leader>ga", ":Git add %<CR>", desc = "Add current file" },
    { "<leader>gC", ":Git commit -v<CR>", desc = "Commit" },
    { "<leader>gm", ":Git merge ", desc = "Merge" },
    { "<leader>gd", ":Gvdiffsplit!<CR>", desc = "Diff" },
    { "<leader>gD", ":diffoff!<CR>", desc = "Quit diff mode" },
    { "<leader>gh", group = "Hunk",
      { "<leader>ghs", gitsigns.stage_hunk, desc = "Stage" },
      { "<leader>ghr", gitsigns.reset_hunk, desc = "Reset" },
      { "<leader>ghp", gitsigns.preview_hunk, desc = "Preview" },
      { "<leader>ghi", gitsigns.preview_hunk_inline, desc = "Preview inline" },
      { "<leader>ghb", function()
        gitsigns.blame_line({ full = true })
      end, desc = "Blame line" },
    }
  },
  {
    { "<C-s>", ":write<CR>", desc = "Save", },
    { "<F5>", ":update<CR> :source<CR>", desc = "Source file", },
    { "<C-h>", "<C-w>h", desc = "Move to left window" },
    { "<C-j>", "<C-w>j", desc = "Move to bottom window" },
    { "<C-k>", "<C-w>k", desc = "Move to top window" },
    { "<C-l>", "<C-w>l", desc = "Move to right window" },
    { "<A-h>", ":vertical resize -2<CR>", desc = "Decrease window width" },
    { "<A-l>", ":vertical resize +2<CR>", desc = "Increase window width" },
    { "<A-j>", ":resize -2<CR>", desc = "Decrease window height" },
    { "<A-k>", ":resize +2<CR>", desc = "Increase window height" },
    { "<A-=>", "<C-w>=<CR>", desc = "Automatically resize windows" },
  },
  {
    mode = "i",
    { "jk", "<esc>" },
    { "kj", "<esc>" }
  },
  {
    mode = "v",
    { "<", "<gv", desc = "Indent selected <" },
    { ">", ">gv", desc = "Indent selected >" },
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
    { "s", flash.jump, desc = "Flash" },
    { "S", flash.treesitter, desc = "Flash treesitter" },
  },
  {
    mode = { "o", "x" },
    { "R", flash.treesitter_search, desc = "Treesitter search" },
  },
})
