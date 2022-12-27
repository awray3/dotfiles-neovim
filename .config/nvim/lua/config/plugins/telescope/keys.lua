local M = {}

function M.setup(client, buffer)
    local wk = require("which-key")
    local cap = client.server_capabilities

    local builtins=require("telescope.builtin")

    local keymap = {
        buffer = buffer,
        ["<leader>"] = {
            -- configs
            i = {
                name = "+edit config",
                n = {
                    "<Cmd>e $NEOHOME/init.lua<CR> <Cmd>cd $NEOHOME<CR>",
                    "Open Neovim dotfiles"
                },
                z = {
                    "<Cmd>e $ZSH/zshrc.zsh<CR> <Cmd>cd $ZSH<CR>",
                    "Open Zsh dotfiles"
                }
            },
            ["?"] = {
                builtins.oldfiles,
                '[?] Find recently opened files'
            },
            ["/"] = {
                function()
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    })
                end,
                "[/] Fuzzily search in current buffer"
            },
            -- searching
            s = {
                name = "+[S]earch",
                f = {
                    builtins.find_files,
                    "[F]iles"
                },
                h = {
                    builtins.help_tags,
                    "[H]elp docs"
                },
                ['#'] = {
                    builtins.grep_string,
                    "for [W]ord under cursor"
                },
                g = {
                    builtins.live_grep,
                    'by [G]rep'
                },
                d = {
                    builtins.diagnostics,
                    "[D]iagnostics"
                },
                k = {
                    builtins.keymaps,
                    "[K]eymaps"
                }

            }
        }
    }
    wk.register(keymap)
end

return M
-- telescope keybindings
-- vim.keymap.set('n', "<leader>in", 
-- vim.keymap.set('n', "<leader>iz", 
--vim.keymap.set('n', '<C-n>', '<Cmd>Telescope file_browser<CR>', opts)
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

-- vim.keymap.set('n', '<leader>/', 
-- , { desc = '[/] 

-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })

-- telescope search-under-word (replaces default # action)
-- vim.keymap.set('n', '#', '<Cmd>Telescope grep_string<CR>')