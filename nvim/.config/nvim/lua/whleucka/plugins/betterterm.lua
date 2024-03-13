return {
	'CRAG666/betterTerm.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local betterTerm = require('betterTerm')
		require('betterTerm').setup {
		  prefix = "Term_",
		  startInserted = true,
		  position = "bot",
		  size = 10
		}
		vim.keymap.set({ "n", "t" }, "<C-;>", betterTerm.open, { desc = "Open terminal" })
	end
}
