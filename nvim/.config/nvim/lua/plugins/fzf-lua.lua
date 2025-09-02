vim.pack.add({
  {
    src = "https://github.com/ibhagwan/fzf-lua",
  }
})

require("fzf-lua").setup({ 'fzf-native' })
local wk = require("which-key")
wk.add({
  {
    "<leader>s",
    group = "Search",
    { "<leader>sg", ":FzfLua grep<cr>",      desc = "Grep" },
    { "<leader>s/", ":FzfLua live_grep<cr>", desc = "Live grep" },
  },
  {
    "<leader>f",
    group = "Find",
    { "<leader>ff", ":FzfLua files<cr>",     desc = "Files" },
    { "<leader>fh", ":FzfLua helptags<cr>",  desc = "Help" },
    { "<leader>fc", ":FzfLua commands<cr>",  desc = "Commands" },
    { "<leader>fm", ":FzfLua manpages<cr>",  desc = "Manpages" },
    { "<leader>fk", ":FzfLua keymaps<cr>",   desc = "Keymap" },
    { "<leader>fg", ":FzfLua git_files<cr>", desc = "Git files" },
    { "<leader>fo", ":FzfLua oldfiles<cr>",  desc = "Opened files" },
    { "<leader>fb", ":FzfLua buffers<cr>",   desc = "Buffers" },
    { "<leader>ft", ":FzfLua tabs<cr>",      desc = "Tabs" },
    { "<leader>f/", ":FzfLua blines<cr>",    desc = "Lines" },
    { "<leader>fq", ":FzfLua quickfix<cr>",  desc = "Quickfix" },
    { "<leader>fl", ":FzfLua loclist<cr>",   desc = "Location list" },
  },
})
