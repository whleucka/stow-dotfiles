vim.pack.add({
  {
    src = "https://github.com/whleucka/sshfs.nvim",
    name = "sshfs",
  }
})

require("sshfs").setup({
  connections = {
    ssh_configs = require("sshfs.core.config").get_default_ssh_configs(),
    sshfs_args = { -- these are the sshfs options that will be used
      "-o reconnect",            -- Automatically reconnect if the connection drops
      "-o ConnectTimeout=5",     -- Time (in seconds) to wait before failing a connection attempt
      "-o compression=yes",      -- Enable compression to reduce bandwidth usage
      "-o ServerAliveInterval=15", -- Send a keepalive packet every 15 seconds to prevent timeouts
      "-o ServerAliveCountMax=3",  -- Number of missed keepalive packets before disconnecting
    },
  },
  mounts = {
    base_dir = vim.fn.expand("$HOME") .. "/.mount", -- where remote mounts are created
    unmount_on_exit = true, -- auto-disconnect all mounts on :q or exit
    auto_change_dir_on_mount = false, -- auto-change current directory to mount point (default: false)
  },
  host_paths = {
    ['cl-alpha'] = '/var/www/alpha.chainlogic.net/web/will/cms/',
    ['ic-atm'] = {
      '/var/www/dev.instacoinatm.com/',
      '/var/www/beta.instacoinatm.com/',
      '/var/www/instacoinatm.com/',
    },
    ['chainlogic'] = '/mnt/enc/chainlogic-dev',
    ['elitedesk'] = '/home/whleucka/Projects/',
  },
  handlers = {
    on_disconnect = {
      clean_mount_folders = true, -- optionally clean up mount folders after disconnect
    },
  },
  ui = {
    file_picker = {
      auto_open_on_mount = true, -- auto-open picker after connecting
      preferred_picker = "auto", -- one of: "auto", "telescope", "oil", "neo-tree", "nvim-tree", "snacks", "fzf-lua", "mini", "yazi", "lf", "nnn", "ranger", "netrw"
      fallback_to_netrw = true,  -- fallback to netrw if no picker is available
    },
  },
  log = {
    enabled = false,
    truncate = false,
    types = {
      all = false,
      util = false,
      handler = false,
      sshfs = false,
    },
  },
})

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
