-- null-ls setup
--
local common = require("aw.lsp.common")

local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")

local writing_filetypes = { "markdown", "vimwiki" }

null_ls.setup({
    debug = false,
    on_attach = function(client, bufnr)
        common.on_attach(client, bufnr)
        -- null-ls formatting
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    sources = {
        builtins.code_actions.refactoring,
        builtins.diagnostics.cppcheck,

        -- python-related
        builtins.diagnostics.flake8,
        builtins.formatting.isort,
        builtins.formatting.black,

        -- markdown formatting
        builtins.diagnostics.markdownlint.with({
            filetypes = writing_filetypes,
        }),
        builtins.formatting.prettier.with({
            extra_args = { "--prose-wrap", "always" },
        }),

        -- lua formatting
        builtins.formatting.stylua,

        -- sh and zsh
        builtins.diagnostics.zsh,
    },
})
