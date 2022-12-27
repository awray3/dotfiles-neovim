--[[
 ____  _             _
|  _ \| |_   _  __ _(_)_ __  ___
| |_) | | | | |/ _` | | '_ \/ __|
|  __/| | |_| | (_| | | | | \__ \
|_|   |_|\__,_|\__, |_|_| |_|___/
               |___/            

This file catches all plugins not containing their own configuration file under `lua/aw/`.
-- ]]
-- This will accept the global Paths variable to generate the
-- correct plugin table.

-- My lsp setup
-- I'm going to make this into a plugin file.
-- https://github.com/ricbermo/yanc/tree/master/lua/config

local utils = require("utils")

return {
    -- pretty icons
    {
        'kyazdani42/nvim-web-devicons',
        event = 'BufRead',
    },
    -- makes scrolling and various other animations smoother.
    {
        'declancm/cinnamon.nvim',
        config = {
            extra_keymaps = true,
        },
    },

    -- dim non-active windows
    {
        'levouh/tint.nvim',
        config = true,
    },

    -- Add indentation guides even on blank lines
    { 'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy' },

    -- no-neck-pain
    {
        'shortcuts/no-neck-pain.nvim',
        keys = {
            {
                '<leader>nn',
                '<Cmd>NoNeckPain<CR>',
                desc = 'Toggle [N]o[N]eckPain',
            }
        },
        config = true,
        cmd = { 'NoNeckPain' },
    },


    --[[ 
      ____ _ _     _   _ _   _ _     
     / ___(_) |_  | | | | |_(_) |___ 
    | |  _| | __| | | | | __| | / __|
    | |_| | | |_  | |_| | |_| | \__ \
     \____|_|\__|  \___/ \__|_|_|___/ 
     git utils ]]

    {
        'tpope/vim-fugitive',
    },
    {
        'akinsho/git-conflict.nvim',
        config = true
    },

    --[[
     __  __ _          
    |  \/  (_)___  ___ 
    | |\/| | / __|/ __|
    | |  | | \__ \ (__ 
    |_|  |_|_|___/\___| ]]

    -- extra syntax file for just
    -- https://github.com/casey/just
    { 'NoahTheDuke/vim-just', ft = { 'just' } },

    -- Quick flip terminal
    -- https://github.com/s1n7ax/nvim-terminal
    {
        's1n7ax/nvim-terminal',
        config = function()
            vim.o.hidden = true
            require('nvim-terminal').setup {
                toggle_keymap = '<leader>j',
            }
        end,
    },

    -- I like this one, but perhaps worth looking
    -- into a newer alterternative? TODO
    { 'tpope/vim-surround' },

    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },

    -- great for clearing out a buffer while leaving the window itself
    {
        'famiu/bufdelete.nvim',
        keys = {
            {
                '<Leader>q',
                function()
                    require('bufdelete').bufdelete(0, true)
                end,
                'Delete buffer',
            },
        }
    },

    -- makes jk and jj work better
    {
        'max397574/better-escape.nvim',
        config = {
            keys = function()
                return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
            end,
        }
    },
    {
        "SmiteshP/nvim-navic",
        config = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
        end,
    },
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- what do these do?
    "windwp/nvim-spectre",
    "folke/twilight.nvim",
    "folke/which-key.nvim",

    -- vim-kitty integration
    {
        'knubie/vim-kitty-navigator',
        cond = utils.env.load_kitty
    },

    --[[ 
      ____      _                
     / ___|___ | | ___  _ __ ___ 
    | |   / _ \| |/ _ \| '__/ __|
    | |__| (_) | | (_) | |  \__ \
     \____\___/|_|\___/|_|  |___/ ]]

    {
        'rcarriga/nvim-notify',
        lazy = false,
        priority = 999,
        config = {
            timeout = 3000,
            level = vim.log.levels.INFO,
            fps = 20,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },

    -- nightfox
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000, -- load this before anything else
        config = function()
            require("nightfox").setup()
            vim.cmd([[colorscheme nightfox]])
        end
    },

    --everforest
    {
        'sainnhe/everforest',
        config = function()
            vim.g.everforest_background = 'soft'
            vim.g.everforest_better_performance = true
            vim.g.everforest_disable_italic_comment = true
            vim.opt.background = 'dark'
        end,
        lazy = true,
    },

    --onedark
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'deep',
                transparent = false,
                ending_tildes = false,
                code_style = {
                    comments = 'none',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none',
                },
            }
        end,
        lazy = true,
    },
}
