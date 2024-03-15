return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup {
			options = {
				theme = "catppuccin"
			},
			sections = {
				lualine_c = {
					'another_item', {
						"harpoon2",
						icon = '♥',
						indicators = { "1", "2", "3", "4", "5", "6", "7", "8" },
						active_indicators = { "[1]", "[2]", "[3]", "[4]","[5]", "[6]", "[7]", "[8]" }
					},
				},
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
