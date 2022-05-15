local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = {'php', 'bash', 'c', 'css', 'html', 'java', 'javascript', 'lua', 'typescript', 'json', 'python', 'cpp', 'scss', 'go', 'rust'}, 
    sync_installed = true,
    highlight = {
        enable = true, -- This is a MUST
        additional_vim_regex_highlighting = { "php" },
    },
    indent = {
        enable = false, -- Really breaks stuff if true
    },
}
