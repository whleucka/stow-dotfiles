return {
	'akinsho/bufferline.nvim',
	dependencies = 'nvim-tree/nvim-web-devicons',
	tag = "v4.5.2", -- this N-1 version seems to be running fine
	config = function()
		require("bufferline").setup {}
	end
}
