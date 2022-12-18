local nvim_tree = require 'nvim-tree'

nvim_tree.setup {
    open_on_setup = false,
    hijack_unnamed_buffer_when_opening = true,
    view = {
        width = 40,
        adaptive_size = true,
    },
    respect_buf_cwd = true,
    create_in_closed_folder = false,
    git = {
        enable = true,
        ignore = false,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        add_trailing = true,
        highlight_opened_files = '2',
        root_folder_label = ':~',
        special_files = {
            'README.md',
            'justfile',
            '.justfile',
            'makefile',
            'tasks.py',
            'init.lua',
            'index.md',
            'index.qmd',
            '.workspace',
            'Dockerfile',
            'dockerfile',
            'docker-compose.*yml',
        },
        highlight_git = true,
        group_empty = true,
        symlink_destination = false,
    },
    filters = {
        custom = {
            '__pycache__',
            '.ipynb_checkpoints',
        },
    },
}

vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')
