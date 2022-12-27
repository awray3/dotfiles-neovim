--[[
This sets up the paths for everything.

 
There are essentially two main data structures, or dictionaries, that store settings in neovim.
    * the environment variable dictionary: lookup is os.getenv("name")
      - VIMRUNTIME
      - MYVIMRC
      - LAZYDIR
      - etc
    * the paths variables dictionary, paths. lookup is paths["name"]
      - lazy.top_level = LAZYDIR
      - lazy.self_path = lazydir / lazy.nvim
      - lazy.lock = lazydir / lazy.lock
      - xdg_conf = XDG_CONFIG_HOME
      - config_home = XDG_CONFIG_HOME if not null, otherwise vim.stdpath config.
      - nvim_config = config_home / nvim
]]
-- local get_env = function(name, default)
--     return os.getenv(name) or default
-- end

local M = {}

-- For debugging vim runtime stuff during development.
-- local function env_debug(env_var)
--     vim.notify(env_var .. ': ' .. tostring(os.getenv(env_var)), vim.log.levels.DEBUG)
-- end

-- Setup environment variables
local env_vars = { 'VIMRUNTIME', 'MYVIMRC', 'VIM', 'CONFIG_DIR', 'XDG_CONFIG_HOME' }

-- vim.notify [[
-- ------------------------------
-- Environment variables received
-- ------------------------------
-- ]]
-- for _, env_var in ipairs(env_vars) do
--     env_debug(env_var)
-- end

-- Variables paths from environment variables
local xdg_conf = os.getenv 'XDG_CONFIG_HOME'
local vim_stdpath = vim.fn.stdpath 'config'

local config_home = xdg_conf or vim_stdpath

return {
    vim_stdpath = vim_stdpath,
    xdg_conf = xdg_conf,
    config_home = config_home,
    lazy = {
        top_level = config_home .. '/lazy',
        self_cache = config_home .. '/lazy/lazy.nvim',
        lock = config_home .. '/nvim/lazy.lock',
    },
    treesitter = {
        top_level = config_home .. '/treesitter',
    },
    nvim = {
        top_level = config_home .. '/nvim',
    },
}