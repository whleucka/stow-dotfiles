-- Main config
require("whleucka.core.options")
require("whleucka.core.keymaps")
require("whleucka.core.autocmds")

-- Plugins
require("whleucka.lib.plugins").setup()

-- Other elements
require("whleucka.lib.bufferline")
require("whleucka.lib.statusline")
