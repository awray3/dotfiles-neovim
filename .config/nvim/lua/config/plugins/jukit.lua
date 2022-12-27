-- repl plugin
local utils = require("utils")

local M = {
    'luk400/vim-jukit',
    ft = { 'julia', 'python' },
    lazy=true
}

-- vim.cmd [[let g:jukit_mappings_ext_enabled = 0]]

-- if utils.env.load_kitty then
--     vim.g.jukit_terminal = 'kitty'
--     vim.g.jukit_output_new_os_window = 1
--     vim.g.jukit_mpl_style = vim.fn['jukit#util#plugin_path'] {} .. '/helpers/matplotlib-backend-kitty/backend.mplstyle'
--     vim.g.jukit_inline_plotting = 1
-- else
--     vim.g.jukit_mpl_style = ''
--     vim.g.jukit_inline_plotting = 0
-- end

local df_columns = function()
    local word_under_cursor = vim.fn.expand '<cword>'
        local cmd = 'list(' .. word_under_cursor .. '.columns' .. ')'
        -- might also be {cmd} or {cmd = cmd} if this doesn't work
        vim.fn['jukit#send#send_to_split'](cmd)
end

-- will this bug out?
-- be on the lookout for jukit keys mapping errors...
-- M.keys = {
--     ["<CR>"] = {
--         {
--             vim.fn["jukit#send#line"],
--             'Send line',
--             mode="n"
--         },
--         {
--             vim.fn["jukit#send#selection"],
--             "Send selection",
--             mode = "v"
--         }
--     },
--     ["<leader>"] = {
--         a = {
--             ll = {
--                 vim.fn["jukit#send#all"],
--                 'Send all cells'
--             }
--         },

--         f = {
--             c = {
--                 df_columns,
--                 'data[F]rame [C]columns'
--             }
--         },
--         o = {
--             s = {
--                 vim.fn["jukit#splits#output"],
--                 "toggle '[O]utput [Split]'"
--             },
--             h = {
--                 s = {
--                     vim.fn["jukit#splits#output_and_history"],
--                     '[O]utput and [H]i[S]tory'
--                 }
--             }
--         },
--         h = {
--             s = {
--                 vim.fn["jukit#splits#history"],
--                 '[H]i[S]tory'
--             }
--         },
--         t = {
--             s = {
--                 vim.fn["jukit#splits#term"],
--                 '[T]erminal [Split]'
--             }
--         },
--         c = {
--             h = {
--                 vim.fn["jukit#splits#close_history"],
--                 '[C]lose [H]istory'
--             },
--             o = {
--                 vim.fn["jukit#splits#close_output_split"],
--                 '[C]lose [Output] window'
--             }
--         }
--     }
-- }
M.keys = {}

vim.cmd [[let g:jukit_mappings=0]]

function M.config()
--     local wk = require("which-key")
--     wk.register(M.keys)


    if utils.env.load_kitty then
        vim.g.jukit_terminal = 'kitty'
        vim.g.jukit_output_new_os_window = 1
        vim.g.jukit_mpl_style = vim.fn['jukit#util#plugin_path'] {} .. '/helpers/matplotlib-backend-kitty/backend.mplstyle'
        vim.g.jukit_inline_plotting = 1
    else
        vim.g.jukit_mpl_style = ''
        vim.g.jukit_inline_plotting = 0
    end
end


return M

-- function M.config()
    -- local jukit_map = function(lhs, rhs, desc, mode)
    --     mode = mode or 'n'
    --     -- vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = ju_desc })
    --     wk.register({
    --         lhs, rhs, 
    --     })
    -- end
    -- jukit_map('<Leader>dc', '<Cmd>lua df_columns()<CR>', '[D]ataframe [C]columns')

    ---------- Managing Jukit Windows

    -- Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
    -- jukit_map('<Leader>os', ':call jukit#splits#output()<cr>', '[O]utput [Split]')

    -- Opens a new output window without executing any command
    -- jukit_map('<Leader>ts', ':call jukit#splits#term()<cr>', '[T]erminal [Split]')

    -- Opens a new output-history window, where saved ipython outputs are displayed
    -- jukit_map('<Leader>hs', ':call jukit#splits#history()<cr>', '[H]i[S]tory')

    -- Opens a new output-history window, where saved ipython outputs are displayed
    -- jukit_map('<Leader>ohs', ':call jukit#splits#output_and_history()<cr>', '[O]utput and [H]i[S]tory')

    -- closes the history window
    -- jukit_map('<Leader>ch', ':call jukit#splits#close_history()<cr>', '[C]lose [H]istory')

    -- close the output window
    -- jukit_map('<Leader>co', ':call jukit#splits#close_output_split()<cr>', '[C]lose [Output] window')

    --------- Sending Code

    -- sends the current cell to output split
    -- jukit_map('<Leader>,', ':call jukit#send#section(0)<cr>', 'Send Selection')

    -- same, but keeps the cursor in the same cell
    -- jukit_map('<Leader><Leader>,', ':call jukit#send#section(1)<cr>', 'Send Selection')

    -- send a line
    -- jukit_map('<cr>', ':call jukit#send#line()<cr>', 'Send line')

    -- send selection
    -- jukit_map('<cr>', ':call jukit#send#selection()<cr>', 'Send Selection', 'v')

    -- send all cells
    -- jukit_map('<Leader>all', ':call jukit#send#all()<cr>', 'Send all cells')

-- end, -- end jukit configuration