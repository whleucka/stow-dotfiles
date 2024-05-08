return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('lualine').setup {
			options = {
				theme = "catppuccin"
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			}
		}
	end
}
