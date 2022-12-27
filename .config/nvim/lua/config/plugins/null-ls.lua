--[[         _ _       _ 
 _ __  _   _| | |     | |___ 
| '_ \| | | | | |_____| / __|
| | | | |_| | | |_____| \__ \
|_| |_|\__,_|_|_|     |_|___/
-- tags: null-ls
--]]
local utils = require("utils")
local writing_filetypes = { 'markdown', 'vimwiki' }
local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
    }
}

-- options should have on_attach
function M.setup(options)
    local nls = require("null-ls")
    local builtins = require 'null-ls.builtins'

    -- null-ls sources
    local sources = {
        -- python-related
        builtins.diagnostics.flake8.with({
            extra_args = {'--ignore=E265,W391,E303'},
            command = "flake8"
        }),
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
            extra_args = { '--config-path', utils.paths.nvim.top_level .. '/.stylua.toml' },
        },

        -- sh and zsh
        builtins.diagnostics.zsh,
    }

    nls.setup({
        debug = true,
        debounce = 150,
        save_after_format = false,
        sources=sources,
        on_attach = options.on_attach,
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
    })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
