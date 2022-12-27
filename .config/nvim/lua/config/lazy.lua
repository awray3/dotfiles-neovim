--[[
 _                                 _           
| |    __ _ _____   _   _ ____   _(_)_ __ ___  
| |   / _` |_  / | | | | '_ \ \ / / | '_ ` _ \ 
| |__| (_| |/ /| |_| |_| | | \ V /| | | | | | |
|_____\__,_/___|\__, (_)_| |_|\_/ |_|_| |_| |_|
                |___/                          ]]
local utils = require 'utils'
local paths = utils.paths

-- I think this is needed to get the correct lazy on the runtime path.
vim.opt.runtimepath:prepend(paths.lazy.self_cache)

-- bootstrap lazy.nvim (from their main setup page)
if not vim.loop.fs_stat(paths.lazy.self_cache) then
    vim.notify('Installing lazy.nvim at ' .. paths.lazy.self_cache)
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        paths.lazy.self_cache,
    }
end

require('lazy').setup('config.plugins', { 
    debug=false,
    defaults = { lazy = true },
    -- root = paths.lazy.top_level,
    lockfile = paths.lazy.lock,
    install = {
        colorscheme = { 'nightfox' },
    },
    checker = { enabled = true },
    diff = {
        cmd = "terminal_git",
        -- TODO: one day use with dunk?
    },
    performance = {
        cache = {
        enabled = true,
        -- disable_events = {},
        },
        rtp = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
            "nvim-treesitter-textobjects",
        },
        },
    },
})

-- open lazy kepmap
require("which-key").register(
    {
        ["<leader>"] = {
            l = {
                "<cmd>Lazy<cr>",
                "Open Lazy"
            }
        }
    }
)
