--
--  ___       _
-- / _ \  ___| |_ ___
--| | | |/ __| __/ _ \
--| |_| | (__| || (_) |
-- \___/ \___|\__\___/
--
local octo = require("octo")

-- this doesn't seem to work yet
octo.setup({
    mappings = {
        issue = {
            --close_issue = { lhs = "<space>ic", desc = "close issue" },
            --reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
            list_issues = { lhs = "<Leader>lo", desc = "list open issues on same repo" },
            --reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            --copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            --add_assignee = { lhs = "<Leader>aa", desc = "add assignee" },
            --remove_assignee = { lhs = "<Leader>ad", desc = "remove assignee" },
            create_label = { lhs = "<Leader>lc", desc = "create label" },
            add_label = { lhs = "<Leader>la", desc = "add label" },
            remove_label = { lhs = "<Leader>ld", desc = "remove label" },
            goto_issue = { lhs = "<Leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<Leader>ca", desc = "add comment" },
            delete_comment = { lhs = "<Leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<Leader>rp", desc = "add/remove 🎉 reaction" },
            --react_heart = { lhs = "<Leader>rh", desc = "add/remove ❤️ reaction" },
            --react_eyes = { lhs = "<Leader>re", desc = "add/remove 👀 reaction" },
            --react_thumbs_up = { lhs = "<Leader>r+", desc = "add/remove 👍 reaction" },
            --react_thumbs_down = { lhs = "<Leader>r-", desc = "add/remove 👎 reaction" },
            --react_rocket = { lhs = "<Leader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<Leader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<Leader>rc", desc = "add/remove 😕 reaction" },
        },
    },
})

local opts = { noremap = true }

vim.keymap.set("n", "<Leader>li", "<Cmd>Octo issue list<CR>", opts)
vim.keymap.set("n", "<Leader>nc", "<Cmd>Octo comment add<CR>", opts)
