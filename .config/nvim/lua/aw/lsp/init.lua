-- _     ____  ____
--| |   / ___||  _ \
--| |   \___ \| |_) |
--| |___ ___) |  __/
--|_____|____/|_|
-- anguage erver rotocol

-- global diagnostics configuration
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = false
})

local configured_servers = { "null-ls", "sumneko-lua", "pyright" }

for _, server in ipairs(configured_servers) do
    require("aw.lsp." .. server)
end

require('aw.completion')
