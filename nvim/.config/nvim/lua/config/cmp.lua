local cmp = require("cmp")         -- The complete engine
local luasnip = require("luasnip") -- The snippet engine
local lspkind = require("lspkind") -- Pretty icons on the automplete list

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
        -- Navigate the dropdown list snippet
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.scroll_docs(-4),
        ["<Down>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        -- Enter select the item
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        -- Use <Tab> as the automplete trigger
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    -- Where to look for auto-complete items.
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "vsnip" },
        { name = "path" },
        { name = "cmdline" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "nvim_lsp_signature_help" },
    },
    -- Improve the dropdown list display: Show incons and show where
    -- the automcomplete sugestion comes from
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
                buffer = "[Buf]",
                path = "[Path]",
                cmdline = "[Cmd]",
                nvim_lsp = "[Lsp]",
                luasnip = "[LuaSnip]",
                vsnip = "[VSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Lat]",
                emoji = "[Emoji]",
            },
        }),
    },
    -- Can be anoying so experiment with it
    experimental = {
        ghost_text = true,
    },
})

-- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--    sources = cmp.config.sources({
--        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--    }, {
--        { name = 'buffer' },
--    })
--})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

