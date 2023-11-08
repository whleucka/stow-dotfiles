return {
	"catppuccin/nvim",
	event = "VimEnter",
	name = "catppuccin",
	priority = 1000,
	integrations = {
		telescope = true,
		treesitter = true,
		neotree = true,
	},
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
