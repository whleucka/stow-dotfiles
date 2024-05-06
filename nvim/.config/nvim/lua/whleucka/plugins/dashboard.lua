return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = '🧙 Resume', group = '@property', action = 'FzfLua resume', key = 'r' },
					{ desc = '⭐ New', group = '@property', action = 'enew', key = 'n' },
					{ desc = '⚡ Sync', group = '@property', action = 'Lazy sync', key = 's' },
					{
						icon = '🧰 ',
						icon_hl = '@variable',
						desc = 'Config',
						group = 'Label',
						action = ":lua require('fzf-lua').files({ cwd = '~/.config/nvim' })",
						key = 'c',
					},
					{
						icon = '🔎 ',
						icon_hl = '@variable',
						desc = 'Find',
						group = 'Label',
						action = ":lua require('fzf-lua').files()",
						key = 'f',
					},
					{
						icon = '💎 ',
						icon_hl = '@variable',
						desc = 'Recent',
						group = 'Label',
						action = ":lua require('fzf-lua').oldfiles()",
						key = 'o',
					},
				},
			},
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
