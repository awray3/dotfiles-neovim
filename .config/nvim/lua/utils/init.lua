-- Utils init.lua
local M = {}

-- Defines an "inspector" function for inspecting lua objects
function M.inspect(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    vim.notify(table.concat(objects, '\n'), vim.log.levels.DEBUG)
    return ...
end

-- Basically a try-except block.
-- usage: tbd?
function M.try(fn, ...)
    local args = { ... }

    return xpcall(function()
        return fn(unpack(args))
    end, function(err)
        local lines = {}
        table.insert(lines, err)
        table.insert(lines, debug.traceback('', 3))

        M.error(table.concat(lines, '\n'))
        return err
    end)
end

--  try to require a module, falling back to
function M.require(mod)
    local ok, ret = M.try(require, mod)
    return ok and ret
end

M.diagnostics_active = true

function M.toggle_diagnostics()
    M.diagnostics_active = not M.diagnostics_active
    if M.diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

function M.toggle(option, silent)
    local info = vim.api.nvim_get_option_info(option)
    local scopes = { buf = "bo", win = "wo", global = "go" }
    local scope = scopes[info.scope]
    local options = vim[scope]
    options[option] = not options[option]
    if silent ~= true then
        if options[option] then
            M.info("enabled vim." .. scope .. "." .. option, "Toggle")
        else
            M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
        end
    end
end

function M.format_sync()
    vim.lsp.buf.format { async = true }
end

function M.warn(msg, name)
    vim.notify(msg, vim.log.levels.WARN, { title = name or 'init.lua' })
end

function M.error(msg, name)
    vim.notify(msg, vim.log.levels.ERROR, { title = name or 'init.lua' })
end

function M.info(msg, name)
    vim.notify(msg, vim.log.levels.INFO, { title = name or 'init.lua' })
end

-- might be unneeded.
M.powerline = {
    circle = {
        left = '',
        right = '',
    },
    arrow = {
        left = '',
        right = '',
    },
    triangle = {
        left = '',
        right = '',
    },
    none = {
        left = '',
        right = '',
    },
}

M.signs = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
    GitAdded = '',
    GitModified = '',
    GitRemoved = '',
    Running = '',
    PassCheck = '',
    CheckAlt = ' ',
    Forbidden = '',
    FolderClosed = '',
    FolderOpen = '',
    FolderEmpty = '',
    LightBulb = '',
    Config = '',
    Branch = '',
    Code = ' ',
    Package = ' ',
    Keyboard = ' ',
    File = ' ',
    Vim = ' ',
    QuestionMark = ' ',
    Loading = ' ',
    Cmd = ' ',
    Event = ' ',
    Init = ' ',
}

function M.get_file_name(include_path)
    local file_name = require('lspsaga.symbolwinbar').get_file_name()
    if vim.fn.bufname '%' == '' then return '' end
    if include_path == false then return file_name end
    -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
    local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
    local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
    local file_path = ''
    for _, cur in ipairs(path_list) do
        file_path = (cur == '.' or cur == '~') and '' or
            file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
    end
    return file_path .. file_name
end

function M.config_winbar_or_statusline()
    local exclude = {
        ['terminal'] = true,
        ['toggleterm'] = true,
        ['prompt'] = true,
        ['NvimTree'] = true,
        ['help'] = true,
        ['alpha'] = true,
    } -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        vim.wo.winbar = ''
    else
        local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
        local sym
        if ok then sym = lspsaga.get_symbol_node() end
        local win_val = ''
        win_val = M.get_file_name(true) -- set to true to include path
        if sym ~= nil then win_val = win_val .. sym end
        vim.wo.winbar = win_val
        -- if work in statusline
        vim.wo.stl = win_val
    end
end

-- See lua/path_setup.lua for path definitions.
M.paths = require('utils.path_setup')

M.env = require("utils.environment")

return M
