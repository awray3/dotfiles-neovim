local lspconfig = require("lspconfig")
local common = require("aw.lsp.common")

local on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    common.on_attach(client, bufnr)
end

-- Lua Language Server
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "bufnr" },
            },
            format = {
                enable = false,
            },
        },
    },
})
