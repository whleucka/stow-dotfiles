return {
	"catppuccin/nvim",
	event = "VimEnter",
	name = "catppuccin",
	priority = 1000,
	opts = {
		integrations = {
			telescope = true,
			treesitter = true,
			neotree = true,
		},
		flavour = "mocha",
		transparent_background = true,
	},
	config = function()
		vim.cmd.colorscheme "catppuccin"
	end
}
