-- Place where packer is goint to be saved
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Install packer from github if is not in our system
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Show packer messages in a popup. Looks cooler
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Alt installation of packer without a function
packer.reset()

local use = packer.use

-- packer can manage itself
use 'wbthomason/packer.nvim'
-- startify
use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function () 
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}
-- lsp
use({
    "neovim/nvim-lspconfig",
    requires = {
        "onsails/lspkind-nvim",
    },
    config = function()
        require("config.lsp")
    end,
})
-- tpope the god
use 'tpope/vim-fugitive'
use 'tpope/vim-repeat'
use 'tpope/vim-sensible'
use 'tpope/vim-surround'
-- autopairs
use {'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup{}
    end
}
-- better tab management
use {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
}
-- leap
use {
    'ggandor/leap.nvim',
    config = function()
        require('leap').set_default_keymaps()
    end
}
-- folds
use 'rayburgemeestre/phpfolding.vim'
-- nvim cmp
use({
    "hrsh7th/nvim-cmp",
    requires = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/nvim-cmp",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
        "onsails/lspkind-nvim",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("config.cmp")
    end,
})
-- telescope
use 'nvim-lua/plenary.nvim'
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use ({
    'nvim-telescope/telescope.nvim',
    config = function()
        require("config.tele")
    end
})
-- tree sitter
use { 
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    config = function()
        require("config.ts")
    end
}
-- git signs
use {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()
    end
}
-- lualine
use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
        require('lualine').setup {
            options = { theme = 'gruvbox' }
        }
    end
}
-- theme
use 'morhetz/gruvbox'
