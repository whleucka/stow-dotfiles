-- Main config
require("whleucka.core.options")
require("whleucka.core.keymaps")
require("whleucka.core.autocmds")

-- Plugins
local plugins = require("whleucka.plugins")
require("whleucka.lib.plugins").setup(plugins)

-- Other elements
require("whleucka.lib.bufferline")
require("whleucka.lib.statusline")
