local lspconfig = require("lspconfig")
local common = require("aw.lsp.common")

local on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    vim.notify("Loaded Pyright language server!")
end

-- pyright
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = common.capabilities,
})
