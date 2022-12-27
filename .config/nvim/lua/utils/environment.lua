-- holds variables for terminal- and gui-related information about the environment where neovim is launched.
-- This can be accessed as require("utils.env")
-- or utils.
-- currently supported:
-- gui: standard neovim, neovide
-- terminal: standard terminals, kitty

local M = {}

M.term = {
    -- this is inherited from the launching process,
    -- regardless of gui.
    is_kitty = vim.env.TERM == 'xterm-kitty'
}

M.gui = {
    -- will be true or nil, I think
    is_neovide = vim.g.neovide
}

-- boolean controlling behavior of lazy loading kitty
-- used by vim-kitty-navigator, nvim-jukit
M.load_kitty = false

if M.gui.is_neovide then
    -- vim.notify 'Launching in Neovide Mode!'
elseif M.term.iskitty then
    -- only loads kitty-related config
    -- when the terminal is kitty and gui not neovide.
    M.load_kitty = true
    -- vim.notify 'Launching in Kitty Mode!'
else
    -- vim.notify 'Launching in Standard Mode!'
end

return M