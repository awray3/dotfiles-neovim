--[[
                        _                 
 _ __   ___  ___       | |_ _ __ ___  ___ 
| '_ \ / _ \/ _ \ _____| __| '__/ _ \/ _ \
| | | |  __/ (_) |_____| |_| | |  __/  __/
|_| |_|\___|\___/       \__|_|  \___|\___| ]]

local M = {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    branch = 'v2.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'MunifTanjim/nui.nvim' },
    },
}

local utils = require 'utils'
-- local neotree = utils.prequire 'neo-tree'
-- if not neotree then
    -- return
-- end

vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

local signs = utils.signs

-- is there a replacement for this?
-- utils.set_custom_symbol('DiagnosticsSignError', signs.Error)
-- utils.set_custom_symbol('DiagnosticsSignInfo', signs.Info)
-- utils.set_custom_symbol('DiagnosticsSignHint', signs.Hint)
-- utils.set_custom_symbol('DiagnosticsSignWarn', signs.Warn)

M.config = {
    popup_border_style = 'rounded',
    enable_git_status = true,
    default_component_configs = {
        icon = {
            folder_closed = signs.FolderClosed,
            folder_open = signs.FolderOpen,
            folder_empty = signs.FolderEmpty,
        },
        git_status = {
            symbols = {
                -- Change type
                added = signs.GitAdded,
                deleted = signs.GitRemoved,
                modified = signs.GitModified,
                renamed = '',
                -- Status type
                untracked = '',
                ignored = '',
                unstaged = '',
                staged = '',
                conflict = '',
            },
        },
    },
    window = {
        position = 'left',
        width = 40,
        number = true,
        relativenumber = true,
    },
    event_handlers = {
        {
            event = 'neo_tree_buffer_enter',
            handler = function()
                vim.cmd [[
                    setlocal relativenumber
            ]]
            end,
        },
    },
}

return M
