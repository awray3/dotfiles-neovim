-- _     ____  ____
--| |   / ___||  _ \
--| |   \___ \| |_) |
--| |___ ___) |  __/
--|_____|____/|_|
-- anguage erver rotocol
-- tags: LSP, lsp, language server protocol


local M = {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim' },
  },
  pin = true
}

-- See this module for all of the default lsp configuration.
--[[ local common_lsp_config = require 'aw.lsp.common' ]]

function M.config()
  -- no setup? seems odd... 
  -- be on the lookout for mason errors.
  require("mason")
  require('fidget').setup()
  require("config.plugins.lsp.diagnostics").setup()

  local function on_attach(client, bufnr)
    -- shows a line at the top with more context. optional.
    --[[ require("nvim-navic").attach(client, bufnr) ]]
    require("config.plugins.lsp.formatting").setup(client, bufnr)
    require("config.plugins.lsp.keys").setup(client, bufnr)
  end

  -- -@type lspconfig.options
  local servers = {
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    html = {},
    jsonls = {
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
    pyright = {},
    yamlls = {},
    sumneko_lua = {
      -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
          misc = {
            parameters = {
              "--log-level=trace",
            },
          },
          diagnostics = {
            -- enable = false,
            groupSeverity = {
              strong = "Warning",
              strict = "Warning",
            },
            groupFileStatus = {
              ["ambiguity"] = "Opened",
              ["await"] = "Opened",
              ["codestyle"] = "None",
              ["duplicate"] = "Opened",
              ["global"] = "Opened",
              ["luadoc"] = "Opened",
              ["redefined"] = "Opened",
              ["strict"] = "Opened",
              ["strong"] = "Opened",
              ["type-check"] = "Opened",
              ["unbalanced"] = "Opened",
              ["unused"] = "Opened",
            },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = false,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              continuation_indent_size = "2",
            },
          },
        },
      },
    },
    vimls = {},
    -- tailwindcss = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    require("lspconfig")[server].setup(opts)
  end

  require("config.plugins.null-ls").setup(options)
end

return M

-- Mason setup
-- require('mason').setup()
-- Turn on lsp status information

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }

-- this needs to come before nvim-lspconfig, which is maybe loaded by mason-lspconfig?

-- Ensure the servers above are installed
-- require('mason-lspconfig').setup {
--   ensure_installed = servers,
-- }

-- require 'aw.lsp.null-ls'

-- for _, lsp in ipairs(servers) do
--   -- sumneko lua handled separately
--   local lspconfig = require("lspconfig")
--   if lsp ~= 'sumneko_lua' then
--     lspconfig[lsp].setup {
--       on_attach = common_lsp_config.on_attach,
--       capabilities = common_lsp_config.capabilities,
--     }
--   elseif lsp == 'sumneko_lua' then
--     -- Make runtime files discoverable to the server
--     local runtime_path = vim.split(package.path, ';', {})
--     table.insert(runtime_path, 'lua/?.lua')
--     table.insert(runtime_path, 'lua/?/init.lua')

--     lspconfig['sumneko_lua'].setup {
--       on_attach = common_lsp_config.on_attach,
--       capabilities = common_lsp_config.capabilities,
--       root_dir = function()
--         return "~/.config/nvim"
--       end,
--       settings = {
--         Lua = {
--           runtime = {
--             -- Tell the language server which version of Lua you're using (most likely LuaJIT)
--             version = 'LuaJIT',
--             -- Setup your lua path
--             path = runtime_path,
--           },
--           diagnostics = {
--             globals = { 'vim', 'bufnr' },
--           },
--           workspace = {
--             library = vim.api.nvim_get_runtime_file('', true),
--             checkThirdParty = false
--           },
--           completion = {
--             enable = true,
--           },
--           format = {
--             enable = false,
--           },
--           telemetry = { enable = false },
--         },
--       },
--     }
--   end
-- end

-- -- Completion is setup here
-- -- nvim-cmp setup
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'

-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
