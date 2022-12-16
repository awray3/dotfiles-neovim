-- null-ls setup
--
local common = require("aw.lsp.common")

local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")

local writing_filetypes = { "markdown", "vimwiki" }

local on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    -- null-ls formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
    vim.notify("Loaded Null-ls language server!")
end

local sources = {
    builtins.code_actions.refactoring,
    builtins.diagnostics.cppcheck,

    -- python-related
    builtins.diagnostics.flake8,
    builtins.formatting.isort,
    builtins.formatting.black,

    -- markdown formatting
    builtins.diagnostics.markdownlint.with({
        extra_filetypes = writing_filetypes,
    }),
    builtins.formatting.prettier.with({
        extra_args = { "--prose-wrap", "always" },
        extra_filetypes = writing_filetypes,
    }),

    -- lua formatting
    builtins.formatting.stylua,

    -- sh and zsh
    builtins.diagnostics.zsh,
}

null_ls.setup({
    debug = false,
    on_attach = on_attach,
    sources = sources,
})
