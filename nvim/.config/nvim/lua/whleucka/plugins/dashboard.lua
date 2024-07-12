return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				project = { enable = true, limit = 8, action = function(path)
					require('fzf-lua').files({ cwd = path })
				end},
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = '⭐ New', group = '@property', action = 'enew', key = 'n' },
					{ desc = '⚡ Lazy', group = '@property', action = 'Lazy', key = 'l' },
					{ desc = '🧙 Mason', group = '@property', action = 'Mason', key = 'm' },
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
				footer = {'With great power comes great responsibility'},
			},
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
