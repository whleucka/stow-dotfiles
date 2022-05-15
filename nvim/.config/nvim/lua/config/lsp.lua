local lspkind = require("lspkind") -- Nice icons

-- Adding icons to the popup
lspkind.init({
    mode = "symbol",
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- Change prefix/character preceding the diagnostics' virtual text
    -- By default, this character is a square icon (■).
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                source = "always",  -- Or "if_many"
                prefix = " 👾",
            },
        }
    )
end

-- Pass configurations settings to the different LSP's
local settings = {
    intelephense = {
        stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
            "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
            "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
            "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
            "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
            "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
            "wordpress", "phpunit",
        },
        diagnostics = {
            enable = true,
        },
    },
    Lua = {
        diagnostics = {
            globals = { "vim" }, -- Gets rid of "Global variable not found" error message
        },
    },
    json = {
        schemas = {
         {
          description = "NPM configuration file",
          fileMatch = {
           "package.json",
          },
          url = "https://json.schemastore.org/package.json",
         },
        },
    },
}

-- Add borders to the popup you get when you "hover" (<S-k>)
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Add capabilities
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig.intelephense.setup {
    on_attach = on_attach,
    flags = flags,
    settings = settings,
    handlers = handlers,
    capabilities = capabilities,
}
lspconfig.tsserver.setup {
    on_attach = on_attach,
    flags = flags,
    settings = settings,
    handlers = handlers,
    capabilities = capabilities,
}
lspconfig.pylsp.setup {
    on_attach = on_attach,
    flags = flags,
    settings = settings,
    handlers = handlers,
    capabilities = capabilities,
}
lspconfig.html.setup {
    on_attach = on_attach,
    flags = flags,
    settings = settings,
    handlers = handlers,
    capabilities = capabilities,
}
lspconfig.cssls.setup {
    on_attach = on_attach,
    flags = flags,
    settings = settings,
    handlers = handlers,
    capabilities = capabilities,
}

-- Equivalent (but not equal) to lspconfig.<langserver>.setup{}
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--lsp_installer.on_server_ready(function(server)
--    server:setup({
--        on_attach = on_attach,
--        flags = flags,
--        settings = settings,
--        handlers = handlers,
--        capabilities = capabilities,
--    })
--end)


-- De clutter the editor by only showing diagnostic messages when the cursor is over the error
vim.diagnostic.config({
    virtual_text = false, -- Do not show the text in front of the error
    float = {
        border = "rounded",
    },
})

-- Change diagnostic symbols in the sign column (gutter)
vim.fn.sign_define("DiagnosticSignError",
{text = "🔥", texthl = "GruvboxRed"})
vim.fn.sign_define("DiagnosticSignWarning",
{text = "⚠️", texthl = "GruvboxYellow"})
vim.fn.sign_define("DiagnosticSignInformation",
{text = "ℹ️", texthl = "GruvboxBlue"})
vim.fn.sign_define("DiagnosticSignHint",
{text = "💡", texthl = "GruvboxAqua"})
