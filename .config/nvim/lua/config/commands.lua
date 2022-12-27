--[[
  ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
 / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
| (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
 \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/ ]]

local utils = require 'utils'

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = '*',
    callback = function()
        utils.config_winbar_or_statusline()
    end,
})

-- Highlight on yank
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true,
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank {
            timeout = 300,
        }
    end,
    group = yank_highlight_group,
    pattern = '*',
})

-- Automatically source and re-compile lazy whenever you save the init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | Lazy! sync',
    pattern = vim.fn.expand '$MYVIMRC',
})
