-- null-ls setup
--
local common = require 'aw.lsp.common'

local null_ls = require 'null-ls'
local builtins = require 'null-ls.builtins'

local writing_filetypes = { 'markdown', 'vimwiki' }

-- This callback function controls what happens in the formatting step.
local callback = function()
    vim.lsp.buf.format {
        bufnr = bufnr,
        filter = function(client)
            return client.name == 'null-ls'
        end,
    }
end

local on_attach = function(client, bufnr)
    -- call the general lsp setup
    common.on_attach(client, bufnr)

    -- null-ls formatting autogroup. This comes from the null-ls wiki on Github.
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = callback, -- uses the callback defined above
        })
    end
    vim.notify 'Loaded Null-ls language server!'
end

-- The sources that null-ls should use, along with their configuration.
local sources = {
    builtins.code_actions.refactoring,
    builtins.diagnostics.cppcheck,

    -- python-related
    builtins.diagnostics.flake8,
    builtins.formatting.isort,
    builtins.formatting.black,

    -- markdown formatting
    builtins.diagnostics.markdownlint.with {
        extra_filetypes = writing_filetypes,
    },
    builtins.formatting.prettier.with {
        extra_args = { '--prose-wrap', 'always' },
        extra_filetypes = writing_filetypes,
    },

    -- lua formatting
    builtins.formatting.stylua.with {
        extra_args = { '--config-path', '/Users/andrew/.config/nvim/.stylua.toml' },
    },

    -- sh and zsh
    builtins.diagnostics.zsh,
}

null_ls.setup {
    debug = true,
    on_attach = on_attach,
    sources = sources,
}
--vim.notify("Loaded Null-ls language server!")
