-- _____    _
--|_   _|__| | ___  ___  ___ ___  _ __   ___
--  | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
--  | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  |_|\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
--  The tool for searching things
-- I think this might take tweaking to work for a bare repo... maybe
-- I think it just gets the list of project files.. lol
local function project_files()
  local opts = {}
  if vim.loop.fs_stat(".git") then
    opts.show_untracked = true
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end


local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim' ,
        'nvim-telescope/telescope-fzf-native.nvim', build = 'make' ,
    },
    cmd = { "Telescope" },
    version = '0.1.0',
  keys = {
    { "<leader>,", project_files, desc = "Find File" },
    -- possibly also leader leader ,
  },
}

function M.config()
    -- local actions = require("telescope.actions")

    local telescope = require("telescope")
    local borderless = true

    telescope.setup {
        defaults = {
            path_display = { shorten = 4 },
            layout_strategy = "horizontal",
            layout_config = {
            prompt_position = "top",
            },
            sorting_strategy = "ascending",
            mappings = {
            i = {
                ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
                end,
                ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
                end,
                ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
                end,
            },
            },
            prompt_prefix = " ",
            selection_caret = " ",
            winblend = borderless and 0 or 10,
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
    telescope.load_extension("fzf")
end

return M