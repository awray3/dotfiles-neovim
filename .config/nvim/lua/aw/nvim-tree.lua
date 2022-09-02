vim.cmd([[
    let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
]])

local nvim_tree = require("nvim-tree")

nvim_tree.setup({
    disable_netrw = false,
    hijack_netrw = false,
    open_on_setup = false,
    hijack_unnamed_buffer_when_opening = true,
    view = {
        width = 30,
        adaptive_size = true,
    },
    respect_buf_cwd = true,
    create_in_closed_folder = false,
    git = {
        enable = true,
        ignore = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        add_trailing = true,
        highlight_opened_files = "2",
        root_folder_modifier = ":~",
        special_files = { "README.md", "Makefile", "MAKEFILE", "tasks.py", "init.vim", "index.md" },
        highlight_git = true,
        group_empty = true,
    },
})

vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")

-- vim.cmd([[
--     nnoremap <C-n> <Cmd>NvimTreeToggle<CR>
--     nnoremap <Leader>r <Cmd>NvimTreeRefresh<CR>

--     " a list of groups can be found at `:help nvim_tree_highlight`
--     highlight NvimTreeFolderIcon guibg=blue
-- ]])
