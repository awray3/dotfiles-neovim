-- Diagnostic Configuration
local M = {}

local utils = require 'utils'

local add_space = function(inp)
    return inp .. ' '
end

M.signs = {
    Error = add_space(utils.signs.Error),
    Warn = add_space(utils.signs.Warn),
    Hint = add_space(utils.signs.Hint),
    Info = add_space(utils.signs.Info),
}

function M.setup()
    -- Automatically update diagnostics
    vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = '●' }, -- might also set to false
        severity_sort = true,
    }

    -- vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    --   local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    --   vim.diagnostic.reset(ns)
    --   return vim.NIL
    -- end

    for type, icon in pairs(M.signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end
end

return M