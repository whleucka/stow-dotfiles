return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				cmp = true,
				flash = true,
				noice = true,
				dap_ui = true,
				lsp_trouble = false,
				which_key = false,
				dashboard = true,
				gitsigns = true,
				markdown = true,
				mason = true,
				neogit = true,
				neotree = true,
				notify = true,
				semantic_tokens = true,
				treesitter = true,
				treesitter_context = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
			flavour = "frappe",
			transparent_background = true,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
