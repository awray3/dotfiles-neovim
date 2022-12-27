-- comment.nvim
-- https://github.com/numToStr/Comment.nvim,
local M = {
    'numToStr/Comment.nvim',
    lazy=true,
    cmd = {""}
}

M.config = {
    padding = true,
    sticky = true,
    toggler = {
        line = '<leader>=',
        block = '<leader>-',
    },
    opleader = {
        ---Line-comment keymap
        line = '<leader>=',
        ---Block-comment keymap
        block = '<leader>-',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
}

return M