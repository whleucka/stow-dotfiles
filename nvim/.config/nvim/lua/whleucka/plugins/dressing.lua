return {
	"stevearc/dressing.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("dressing").setup({
			select = {
				-- Options for fzf-lua
				fzf_lua = {
					winopts = {
					  height = 0.5,
					  width = 0.5,
					},
				},
			},
		})
	end
}
