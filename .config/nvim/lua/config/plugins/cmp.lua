--[[
  ____                      _      _   _             
 / ___|___  _ __ ___  _ __ | | ___| |_(_) ___  _ __  
| |   / _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \ 
| |__| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
 \____\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
                     |_|                              
Github: 
    - https://github.com/hrsh7th/nvim-cmp
    - https://github.com/L3MON4D3/LuaSnip
]]

-- taken from folke
local cmdline = false
local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    { "hrsh7th/cmp-cmdline", enabled = cmdline },
    { "dmitmel/cmp-cmdline-history", enabled = cmdline },
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  vim.o.completeopt = "menuone,noselect"

  -- Setup nvim-cmp.
  local cmp = require("cmp")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "emoji" },
      { name = "neorg" },
    }),
    formatting = {
      format = require("config.plugins.lsp.kind").cmp_format(),
    },
    -- documentation = {
    --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --   winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    -- },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    -- sorting = {
    --   comparators = {
    --     cmp.config.compare.sort_text,
    --     cmp.config.compare.offset,
    --     -- cmp.config.compare.exact,
    --     cmp.config.compare.score,
    --     -- cmp.config.compare.kind,
    --     -- cmp.config.compare.length,
    --     cmp.config.compare.order,
    --   },
    -- },
  })
  if cmdline then
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        -- { name = "noice_popupmenu" },
        { name = "path" },
        { name = "cmdline" },
        -- { name = "cmdline_history" },
      }),
    })
  end
end

return M



-- local lsp_symbols = {
--   Text = "   (Text) ",
--   Method = "   (Method)",
--   Function = "   (Function)",
--   Constructor = "   (Constructor)",
--   Field = " ﴲ  (Field)",
--   Variable = "[] (Variable)",
--   Class = "   (Class)",
--   Interface = " ﰮ  (Interface)",
--   Module = "   (Module)",
--   Property = " 襁 (Property)",
--   Unit = "   (Unit)",
--   Value = "   (Value)",
--   Enum = " 練 (Enum)",
--   Keyword = "   (Keyword)",
--   Snippet = "   (Snippet)",
--   Color = "   (Color)",
--   File = "   (File)",
--   Reference = "   (Reference)",
--   Folder = "   (Folder)",
--   EnumMember = "   (EnumMember)",
--   Constant = " ﲀ  (Constant)",
--   Struct = " ﳤ  (Struct)",
--   Event = "   (Event)",
--   Operator = "   (Operator)",
--   TypeParameter = "   (TypeParameter)"
-- }

-- local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

-- cmp.setup({
--   experimental = {
--     native_menu = false,
--     ghost_text = false,
--   },
--   confirmation = {
--     get_commit_characters = function()
--       return {}
--     end,
--   },
--   completion = {
--     completeopt = "menu,menuone,noinsert",
--   },
--   sources = {
--     { name = "luasnip", keyword_length = 2 },
--     { name = "nvim_lsp", keyword_length = 3 },
--     { name = "path", keyword_length = 3 },
--     { name = "buffer" },
--     { name = "nvim_lsp_signature_help", keyword_length = 3 }
--   },
--   mapping = {
--     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<C-q>"] = cmp.mapping.close(),
--     ["<CR>"] = cmp.mapping.confirm({ select = false }),
--     ["<Up>"] = cmp.mapping.select_prev_item(),
--     ["<Down>"] = cmp.mapping.select_next_item(),
--     ['<C-e>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.close()
--         fallback()
--       else
--         cmp.complete()
--       end
--     end),
--     -- when menu is visible, navigate to next item
--     -- when line is empty, insert a tab character
--     -- else, activate completion
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       local col = vim.fn.col('.') - 1

--       if cmp.visible() then
--         cmp.select_next_item(cmp_select_opts)
--       elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         fallback()
--       else
--         cmp.complete()
--       end
--     end, {'i', 's'}),

--     -- when menu is visible, navigate to previous item on list
--     -- else, revert to default behavior
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item(cmp_select_opts)
--       else
--         fallback()
--       end
--     end, {'i', 's'}),
--   },
--   formatting = {
--     format = function(entry, item)
--       item.kind = lsp_symbols[item.kind]
--       item.menu = ({
--         buffer = "[Buffer]",
--         nvim_lsp = "[LSP]",
--         luasnip = "[Snippet]",
--         path = "[Path]",
--       })[entry.source.name]

--       return item
--     end
--   },
--   snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
--   preselect = cmp.PreselectMode.None,
--   window = {
--     documentation = vim.tbl_deep_extend(
--       'force',
--       cmp.config.window.bordered(),
--       {
--         max_height = 15,
--         max_width = 60,
--       }
--     )
--   }
-- })

-- -- enables autocompletion when entering / or :

-- cmp.setup.cmdline("/", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" },
--   },
-- })

-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = "path" },
--   }, {
--     { name = "cmdline" },
--   }),
-- })
