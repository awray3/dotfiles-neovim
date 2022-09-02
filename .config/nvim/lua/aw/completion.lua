-- [
-- This file runs the setup for completion. More config is needed inside the lsp module
-- to get it to work with the lsp.
-- ]
local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

-- loads the snippets into luasnip
--luasnip.snippets = require("my-snippets")

cmp.setup({
    --snippet = {
    --expand = function(args)
    --luasnip.lsp_expand(args.body) -- For `luasnip` users.
    --end,
    --},
    mapping = {
        ["<C-d>"] = cmp.config.disable,
        ["<C-f>"] = cmp.config.disable,
        ["<C-Space>"] = cmp.config.disable,
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        --{ name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
