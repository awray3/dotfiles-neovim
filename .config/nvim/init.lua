--[[
 _       _ _     _
(_)_ __ (_) |_  | |_   _  __ _
| | '_ \| | __| | | | | |/ _` |
| | | | | | |_  | | |_| | (_| |
|_|_| |_|_|\__(_)_|\__,_|\__,_| 

Github: github.com/awray3/dotfiles-neovim
]]

-- set vim options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- utils.inspect(utils.paths)

-- local paths = require('path_setup').paths
-- this should work
-- local paths = vim.g.paths
require("config.lazy")
require 'config.options'
require("utils.dashboard").setup()

-- not sure
vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require 'config.commands'
        require 'config.mappings'
    end,
})
