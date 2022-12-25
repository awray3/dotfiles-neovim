-- _     ____  ____
--| |   / ___||  _ \
--| |   \___ \| |_) |
--| |___ ___) |  __/
--|_____|____/|_|
-- anguage erver rotocol
-- tags: LSP, lsp, language server protocol

-- general diagnostic configuration
vim.diagnostic.config {
    virtual_text = false,
    update_in_insert = false,
}

-- See this module for all of the default lsp configuration.
local common_lsp_config = require 'aw.lsp.common'

-- Mason setup
require('mason').setup()
-- Turn on lsp status information
require('fidget').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }

-- this needs to come before nvim-lspconfig, which is maybe loaded by mason-lspconfig?

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
    ensure_installed = servers,
}

require 'aw.lsp.null-ls'

for _, lsp in ipairs(servers) do
    -- sumneko lua handled separately
    if lsp ~= 'sumneko_lua' then
        require('lspconfig')[lsp].setup {
            on_attach = common_lsp_config.on_attach,
            capabilities = common_lsp_config.capabilities,
        }
    elseif lsp == 'sumneko_lua' then
        -- Make runtime files discoverable to the server
        local runtime_path = vim.split(package.path, ';', {})
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')

        local lua_ls_on_attach = function (client, bufnr)
          common_lsp_config.on_attach(client, bufnr)
          client.server_capabilities.document_formatting = false
          client.server_capabilities.document_range_formatting = false
        end

        require('lspconfig').sumneko_lua.setup {
            on_attach = lua_ls_on_attach,
            capabilities = common_lsp_config.capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                        version = 'LuaJIT',
                        -- Setup your lua path
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { 'vim', 'bufnr' },
                    },
                    telemetry = { enable = false },
                },
            },
        }
    end
end

-- Completion is setup here
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
