return {
	"gelguy/wilder.nvim",
	build = ":UpdateRemotePlugins",
	event = "CmdlineEnter",
	config = function()
		local wilder = require('wilder')
		wilder.setup({ modes = { ':', '/', '?' } })
		wilder.set_option('renderer', wilder.popupmenu_renderer({
			-- highlighter applies highlighting to the candidates
			highlighter = wilder.basic_highlighter(),
		}))
	end,
}
