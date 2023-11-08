return {
    'beauwilliams/statusline.lua',
    event = "BufRead",
    config = function()
        local statusline = require("statusline")
        statusline.tabline = false
    end
}
