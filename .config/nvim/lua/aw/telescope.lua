-- _____    _
--|_   _|__| | ___  ___  ___ ___  _ __   ___
--  | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
--  | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  |_|\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
--  The tool for searching things

local telescope = require 'telescope'
local opts = { noremap = true, silent = true }

--local telescope_bindings = {
--[''] = 'builtin',
--f = 'find_files',
--g = 'live_grep',
--h = 'help_tags',
--j = 'jump_list',
--s = 'current_buffer_fuzzy_find',
--m = 'man_pages',
--r = 'lsp_references',
--d = 'lsp_definitions',
--c = 'colorscheme',
--k = 'file_browser',
--}

-- telescope search-under-word (replaces default # action)
--vim.keymap.set('n', '#', '<Cmd>Telescope grep_string<CR>')

--for postfix_key, cmd in pairs(telescope_bindings) do
--vim.keymap.set('n', '<leader>t' .. postfix_key, '<cmd>Telescope ' .. cmd .. ' <CR>', opts)
--end

-- local open_dotfiles = function(cwd)
--     return function()
--         require('telescope.builtin').find_files {
--             require('telescope.themes').get_ivy(),
--             cwd = cwd,
--         }
--         -- something like vim.fn['cd'](cwd) maybe? but needs to be on the action?
--     end
-- end

-- vim.keymap.set('n', '<leader>tn', open_dotfiles '$NEOHOME', opts)

telescope.setup {
    defaults = {
        path_display = { shorten = 4 },
    },

    pickers = {
        find_files = {
            find_command = {
                "rg", "-L", "--files"
            }
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = false,
            grouped = true,
            depth = false,
            hidden=false
        },
    },
}

--pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')

-- telescope keybindings

vim.keymap.set('n', "<leader>in", "<Cmd>e $NEOHOME/init.lua<CR> <Cmd>cd $NEOHOME<CR>", opts)
vim.keymap.set('n', "<leader>iz", "<Cmd>e $ZSH/zshrc.zsh<CR> <Cmd>cd $ZSH<CR>", opts)
--vim.keymap.set('n', '<C-n>', '<Cmd>Telescope file_browser<CR>', opts)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
