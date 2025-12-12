vim.pack.add({
  {
    src = "https://github.com/uhs-robert/sshfs.nvim",
    name = "sshfs",
  }
})

local config = require("config.sshfs")
require("sshfs").setup(config)

local wk = require("which-key")
wk.add({
  {
    "<leader>m",
    group = "SSHFS",
    {
      {"<leader>mm", ":SSHConnect<cr>", desc = "SSHFS Mount"},
      {"<leader>mu", ":SSHDisconnect<cr>", desc = "SSHFS Disconnect"},
      {"<leader>mr", ":SSHReload<cr>", desc = "SSHFS Reload"},
      {"<leader>mf", ":SSHBrowse<cr>", desc = "SSHFS Browse"},
      {"<leader>md", ":SSHChangeDir<cr>", desc = "SSHFS Change Directory"},
      {"<leader>mg", ":SSHGrep<cr>", desc = "SSHFS Grep"},
      {"<leader>me", ":SSHEdit<cr>", desc = "SSHFS Edit Config"},
    },
  },
})
