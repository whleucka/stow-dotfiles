return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",   -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim",  -- optional
		"ibhagwan/fzf-lua",        -- optional
	},
	config = function()
		local neogit = require('neogit')
		neogit.setup({})
		local group = vim.api.nvim_create_augroup('MyCustomNeogitEvents', { clear = true })
		vim.api.nvim_create_autocmd('User', {
		  pattern = 'NeogitPushComplete',
		  group = group,
		  callback = neogit.close,
		})
	end,
	cmd = "Neogit",
	keys = {
		{ "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Neogit" }
	}
}
