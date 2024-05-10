return {
	'akinsho/bufferline.nvim',
	after = "catppuccin",
	tag = "v4.5.2",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require("bufferline").setup {
			highlights = require("catppuccin.groups.integrations.bufferline").get()
		}
	end
}
