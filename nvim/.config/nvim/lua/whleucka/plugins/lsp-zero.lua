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
			ensure_installed = {'codelldb'},
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
					codelldb = function(config)
						config.adapters = {
							type = 'server',
							port = "${port}",
							executable = {
								command = 'codelldb',
								args = {"--port", "${port}"},
							}
						}
						config.configurations = {
							{
								name = "Launch file",
								type = "codelldb",
								request = "launch",
								program = function()
									return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
								end,
								cwd = '${workspaceFolder}',
								stopOnEntry = false,
								args = {},
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
			})
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()
		end,
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
		}
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
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered({
						winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
						col_offset = -3,
						side_padding = 1,
					}),
				},
				formatting = {
					fields = { "kind", "abbr" },
					format = function(entry, vim_item)
						if vim.tbl_contains({ 'path' }, entry.source.name) then
							local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
							if icon then
								vim_item.kind = icon
								vim_item.kind_hl_group = hl_group

								return vim_item
							end
						end
						return require('lspkind').cmp_format({
							maxwidth = 20, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							-- can also be a function to dynamically calculate max width such as
							-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
							ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
							with_text = false
						})(entry, vim_item)
					end
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
			-- Customization for Pmenu
			-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
			-- vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
			-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
			-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
			-- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
			--
			-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
			-- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
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
			local lsp = vim.lsp
			lsp_zero.extend_lspconfig()

			-- Inlay hints
			lsp.inlay_hint.enable()

			lsp_zero.on_attach(function(client, bufnr)

				-- Lenses
				if client and client.supports_method(lsp.protocol.Methods.textDocument_codeLens) then
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = ev.buf,
						group = vim.api.nvim_create_augroup("codelens", { clear = false }),
						callback = function()
							lsp.codelens.refresh()
						end,
					})
				end

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
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					'clangd', 'intelephense', 'html', 'cssls', 'bashls', 'rust_analyzer', 'tsserver', 'jedi_language_server'
				},
				handlers = {
					lsp_zero.default_setup,
					clangd = function()
						require('lspconfig').clangd.setup({
							capabilities = {
								offsetEncoding = 'utf-8',
							},
						})
					end,
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


