return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				telescope = true,
				treesitter = true,
				neotree = true,
				neogit = true,
			},
			flavour = "mocha",
			transparent_background = true,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
