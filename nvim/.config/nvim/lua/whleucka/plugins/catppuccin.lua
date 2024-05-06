return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				cmp = true,
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
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
			flavour = "frappe",
			transparent_background = true,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
