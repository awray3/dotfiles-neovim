-- _____                   _ _   _
--|_   _| __ ___  ___  ___(_) |_| |_ ___ _ __
--  | || '__/ _ \/ _ \/ __| | __| __/ _ \ '__|
--  | || | |  __/  __/\__ \ | |_| ||  __/ |
--  |_||_|  \___|\___||___/_|\__|\__\___|_|

local treesitter = require 'nvim-treesitter.configs'
local playground = require 'aw.treesitter.playground'
local textobjects = require 'aw.treesitter.textobjects'
local parsers = require 'nvim-treesitter.parsers'

treesitter.setup {
    ensure_installed = { 'help', 'bash', 'comment', 'python', 'json', 'lua', 'yaml', 'vim', 'markdown' },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    indent = {
        enable = true,
    },
    playground = playground,
    textobjects = textobjects,
}

-- the quarto filetype will use the python parser and queries.
parsers.filetype_to_parsername.quarto = 'markdown'
