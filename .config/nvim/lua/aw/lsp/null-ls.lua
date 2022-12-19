--[[         _ __  _   _| | |     | |___ 
            | '_ \| | | | | |_____| / __|
            | | | | |_| | | |_____| \__ \
            |_| |_|\__,_|_|_|     |_|___/
-- tags: null-ls
--]]
local common = require 'aw.lsp.common'

local null_ls = require 'null-ls'
local builtins = require 'null-ls.builtins'

local writing_filetypes = { 'markdown', 'vimwiki' }

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
    on_attach = common.on_attach,
    sources = sources,
}
