return {
	{
		'VonHeikemen/lsp-zero.nvim',
		lazy = true,
		branch = 'v3.x',
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text"
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					width = 0.8,
					height = 0.9,
				},
			})
			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {
					php = function(config)
						config.configurations = {
							{
								type = "php",
								request = "launch",
								name = "Listen for Xdebug",
								localSourceRoot = vim.fn.expand("%:p:h") .. "/",
								port = 9003,
								log = true,
							},
						}
						require('mason-nvim-dap').default_setup(config) -- don't forget this!
					end,
					python = function(config)
						config.configurations = {
							{
								type = 'python',
								request = 'launch',
								name = "Python",
								program = "${file}",
								command = "/usr/bin/python3",
							},
						}
						require('mason-nvim-dap').default_setup(config) -- don't forget this!
					end
				},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					'php', 'python', 'rust'
				},
			})
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()
		end,
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'onsails/lspkind.nvim' },
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp"
			},
			{ 'f3fora/cmp-spell' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'FelipeLema/cmp-async-path' },
			{ 'hrsh7th/cmp-emoji' },
			{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_cmp()
			local luasnip = require 'luasnip'
			local lspkind = require('lspkind')

			-- And you can configure cmp even more, if you want to.
			local cmp = require('cmp')

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				experimental = {
					ghost_text = true,
				},
				sources = {
					{ name = "nvim_lsp",                priority = 1000 },
					{ name = "nvim_lsp_signature_help", priority = 850 },
					{ name = "luasnip",                 priority = 800 },
					{
						name = 'spell',
						priority = 600,
						option = {
							keep_all_entries = false,
							enable_in_context = function()
								return true
							end,
						},
					},
					{ name = "buffer",     priority = 500, keyword_length = 4 },
					{ name = "emoji",      priority = 400 },
					{ name = "async_path", priority = 250 },
					{ name = "nvim_lua",   priority = 200 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text', -- show only symbol annotations
						preset = 'default',
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							return vim_item
						end
					})
				},
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete {},
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				})
			})
		end
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			-- Inlay hints
			vim.lsp.inlay_hint.enable()

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
				-- K:
				--     Displays hover information about the symbol under the cursor in a
				--     floating window. See |vim.lsp.buf.hover()|.
				--
				-- gd:
				--     Jumps to the definition of the symbol under the cursor.
				--     See |vim.lsp.buf.definition()|.
				--
				-- gD:
				--     Jumps to the declaration of the symbol under the cursor. Some servers
				--     don't implement this feature. See |vim.lsp.buf.declaration()|.
				--
				-- gi:
				--     Lists all the implementations for the symbol under the cursor in the
				--     quickfix window. See |vim.lsp.buf.implementation()|.
				--
				-- go:
				--     Jumps to the definition of the type of the symbol under the cursor.
				--     See |vim.lsp.buf.type_definition()|.
				--
				-- gr:
				--     Lists all the references to the symbol under the cursor in the quickfix
				--     window. See |vim.lsp.buf.references()|.
				--
				-- gs:
				--     Displays signature information about the symbol under the cursor in a
				--     floating window. See |vim.lsp.buf.signature_help()|. If a mapping
				--     already exists for this key this function is not bound.
				--
				-- <F2>:
				--     Renames all references to the symbol under the cursor.
				--     See |vim.lsp.buf.rename()|.
				--
				-- <F3>:
				--     Format a buffer using the LSP servers attached to it.
				--     See |vim.lsp.buf.format()|.
				--
				-- <F4>:
				--     Selects a code action available at the current cursor position.
				--     See |vim.lsp.buf.code_action()|.
				--
				-- gl:
				--     Show diagnostic in a floating window. See |vim.diagnostic.open_float()|.
				--
				-- [d:
				--     Move to the previous diagnostic in the current buffer.
				--     See |vim.diagnostic.goto_prev()|.
				--
				-- ]d:
				--     Move to the next diagnostic. See |vim.diagnostic.goto_next()|.
			end)

			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require('lspconfig').lua_ls.setup(lua_opts)
					end,
				}
			})

			require('lspconfig.ui.windows').default_options.border = 'rounded'
		end
	}
}
