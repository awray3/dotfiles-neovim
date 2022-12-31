--[[
  ___       _
 / _ \  ___| |_ ___
| | | |/ __| __/ _ \
| |_| | (__| || (_) |
 \___/ \___|\__\___/ 

Plugin for interfacing with Github issues/PRs/etc with
a telescope selector. Something about Github and octopi?
I haven't quite figured out why that one is yet...
]]

local M = {
    'pwntester/octo.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
    },
    cmd = {'Octo'},
}

-- replaces this
-- vim.keymap.set('n', '<Leader>li', '<Cmd>Octo issue list<CR>', opts)
-- vim.keymap.set('n', '<Leader>nc', '<Cmd>Octo comment add<CR>', opts)
-- vim.keymap.set('n', '<Leader>lc', '<Cmd>Octo issue create<CR>', opts)
-- will this work with which-key and lazy?
M.keys = {
    ["<leader>"] = {
        l = {
            i = {
                "<Cmd>Octo issue list<CR>",
                "List Github Issues"
            },
            c = {
                '<Cmd>Octo issue create<CR>',
                "Create an Issue"
            }
        },
        n = {
            c = {
                '<Cmd>Octo comment add<CR>',
                "Add a comment to an issue"
            }
        }
    }
}

-- this doesn't seem to work yet
function M.config()

    require("which-key").register(M.keys)
    local opts = {
        mappings = {
            issue = {
                --close_issue = { lhs = "<space>ic", desc = "close issue" },
                --reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
                list_issues = { lhs = '<Leader>lo', desc = 'list open issues on same repo' },
                --reload = { lhs = "<C-r>", desc = "reload issue" },
                open_in_browser = { lhs = '<C-b>', desc = 'open issue in browser' },
                --copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
                --add_assignee = { lhs = "<Leader>aa", desc = "add assignee" },
                --remove_assignee = { lhs = "<Leader>ad", desc = "remove assignee" },
                --create_label = { lhs = "<Leader>lc", desc = "create label" },
                --add_label = { lhs = "<Leader>la", desc = "add label" },
                --remove_label = { lhs = "<Leader>ld", desc = "remove label" },
                --add_comment = { lhs = "<Leader>ac", desc = "add comment" },
                --delete_comment = { lhs = "<Leader>cd", desc = "delete comment" },
                next_comment = { lhs = ']c', desc = 'go to next comment' },
                prev_comment = { lhs = '[c', desc = 'go to previous comment' },
                react_hooray = { lhs = '<Leader>ry', desc = 'add/remove 🎉 reaction' },
                react_laugh = { lhs = '<Leader>rl', desc = 'add/remove 😄 reaction' },
                react_confused = { lhs = '<Leader>rc', desc = 'add/remove 😕 reaction' },
                --react_heart = { lhs = "<Leader>rh", desc = "add/remove ❤️ reaction" },
                --react_eyes = { lhs = "<Leader>re", desc = "add/remove 👀 reaction" },
                --react_thumbs_up = { lhs = "<Leader>r+", desc = "add/remove 👍 reaction" },
                --react_thumbs_down = { lhs = "<Leader>r-", desc = "add/remove 👎 reaction" },
                --react_rocket = { lhs = "<Leader>rr", desc = "add/remove 🚀 reaction" },
            },
        },
    }
end

return M
