return {
	'akinsho/bufferline.nvim',
	after = "catppuccin",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require("bufferline").setup {
			highlights = require("catppuccin.groups.integrations.bufferline").get()
		}
	end
}
