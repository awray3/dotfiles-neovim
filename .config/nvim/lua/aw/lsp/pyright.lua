local lspconfig = require("lspconfig")
local common = require("aw.lsp.common")

-- pyright
lspconfig.pyright.setup({
    on_attach = common.on_attach,
})
