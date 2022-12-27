--[[
 __  __                                    _           
|  \/  | __ _ ___  ___  _ __    _ ____   _(_)_ __ ___  
| |\/| |/ _` / __|/ _ \| '_ \  | '_ \ \ / / | '_ ` _ \ 
| |  | | (_| \__ \ (_) | | | |_| | | \ V /| | | | | | |
|_|  |_|\__,_|___/\___/|_| |_(_)_| |_|\_/ |_|_| |_| |_|]]

local M = {
    'williamboman/mason.nvim',
    cmd = {
        'Mason',
        'MasonInstall',
        'MasonUninstall',
        'MasonUninstallAll',
        'MasonLog',
    },
}

local signs = require('utils').signs

M.config = {
    ui = {
        icons = {
            package_installed = signs.PassCheck,
            package_pending = signs.Running,
            package_uninstalled = signs.GitRemoved,
        },
    },
}

return M
