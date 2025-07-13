local path = vim.fn.stdpath("data") .. "/site/pack/base"
local plugins = require("whleucka.plugins")

return {
  base_path = path,
  plugins = plugins,
}
