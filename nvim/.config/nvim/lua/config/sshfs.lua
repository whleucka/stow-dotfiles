return {
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
}
