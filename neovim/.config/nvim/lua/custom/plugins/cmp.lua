return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    'hrsh7th/cmp-nvim-lsp',
    "f3fora/cmp-spell",
    "lukas-reineke/cmp-rg",

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Icons
    "onsails/lspkind.nvim"
  },
}
