-- _____                   _ _   _
--|_   _| __ ___  ___  ___(_) |_| |_ ___ _ __
--  | || '__/ _ \/ _ \/ __| | __| __/ _ \ '__|
--  | || | |  __/  __/\__ \ | |_| ||  __/ |
--  |_||_|  \___|\___||___/_|\__|\__\___|_|

local treesitter = require("nvim-treesitter.configs")
local playground = require("aw.treesitter.playground")
local textobjects = require("aw.treesitter.textobjects")

treesitter.setup({
    ensure_installed = {
        "bash",
        "comment",
        "python",
        "json",
        "lua",
        "yaml",
        "vim",
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
        enable = true,
    },
    playground = playground,
    textobjects = textobjects,
})
