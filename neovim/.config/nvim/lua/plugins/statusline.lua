return {
    'beauwilliams/statusline.lua',
    lazy = true,
    event = "BufRead",
    config = function()
        local statusline = require("statusline")
        statusline.tabline = false
    end
}
