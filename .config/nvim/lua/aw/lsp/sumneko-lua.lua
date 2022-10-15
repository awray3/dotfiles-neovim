local lspconfig = require("lspconfig")
local common = require("aw.lsp.common")

local on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

local capabilities = common.capabilities

-- Lua Language Server
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "bufnr" },
            },
            format = {
                enable = false,
            },
            completion = {
                enable = true,
            },
            runtime = {
                version = "LuaJIT",
            },
        },
    },
})
