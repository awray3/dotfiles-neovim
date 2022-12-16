--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_  | | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|


-- per the nvim-tree docs, this should come at the very top of the neovim configuration
-- to avoid race conditions with netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- bootstrap and setup packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- clear any loaded packages, so submodules refresh with config refresh.
for k, _ in pairs(package.loaded) do
    if string.match(k, "^aw") then
        package.loaded[k] = nil
    end
end

--  ____  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/

local terminal_is_kitty = vim.env.TERM == "xterm-kitty"

require("packer").startup({
    function(use)
        use("wbthomason/packer.nvim") -- Package manager

        --   ___ ___  _ __ ___
        --  / __/ _ \| '__/ _ \
        -- | (_| (_) | | |  __/
        --  \___\___/|_|  \___|

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("aw.treesitter")
            end,
        })
        -- Additional textobjects for treesitter
        use("nvim-treesitter/nvim-treesitter-textobjects")
        use("nvim-treesitter/playground")

        use({
            "nvim-telescope/telescope.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("aw.telescope")
            end,
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
        })
        use({ "nvim-telescope/telescope-file-browser.nvim" })
        use({
            "pwntester/octo.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("aw.octo")
            end,
            -- Notes: this is for adding Github issues to my telescope selector
        })
        use({
            "s1n7ax/nvim-terminal",
            config = function()
                vim.o.hidden = true
                require("nvim-terminal").setup({
                    toggle_keymap = "<leader>j",
                })
            end,
            -- a simple, flip open and close terminal just like vscode has.
        })
        use("tpope/vim-surround")
        use({
            "kyazdani42/nvim-tree.lua",
            requires = { "kyazdani42/nvim-web-devicons" },
            tag = "nightly",
            config = function()
                require("aw.nvim-tree")
            end,
        })
        use({
            "preservim/nerdcommenter",
            config = function()
                vim.g.NERDCreateDefaultMappings = false
                vim.keymap.set("n", "<Leader>/", "<Plug>NERDCommenterToggle", { noremap = true })
                vim.keymap.set("v", "<Leader>/", "<Plug>NERDCommenterToggle", { noremap = true })
            end,
        })

        if terminal_is_kitty then
            use("knubie/vim-kitty-navigator")
        end

        use({
            "windwp/nvim-autopairs",
            config = function()
                local autopairs = require("nvim-autopairs")
                autopairs.setup({})
                autopairs.remove_rule("`")
            end,
        })

        -- makes scrolling smoother
        use({
            "declancm/cinnamon.nvim",
            config = function()
                require("cinnamon").setup({
                    extra_keymaps = true,
                })
            end,
        })

        -- Lua
        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup({
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                })
            end,
        })
        --  _     ____  ____
        -- | |   / ___||  _ \
        -- | |   \___ \| |_) |
        -- | |___ ___) |  __/
        -- |_____|____/|_|

        use({
            "neovim/nvim-lspconfig",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
        })

        use({ "L3MON4D3/LuaSnip" })

        use(
            { "mfussenegger/nvim-dap" }
            -- main debugger plugin
        )

        --  _   _ ___
        -- | | | |_ _|
        -- | | | || |
        -- | |_| || |
        --  \___/|___|

        -- colorschemes
        use({
            "sainnhe/everforest",
            config = function()
                vim.g.everforest_background = "soft"
                vim.g.everforest_better_performance = 1
                vim.g.everforest_disable_italic_comment = 1
                vim.opt.background = "dark"
            end,
        })
        -- use 'safv12/andromeda.vim'
        use("navarasu/onedark.nvim")

        -- lines
        use({
            "nvim-lualine/lualine.nvim",
            requires = {
                "kyazdani42/nvim-web-devicons",
                opt = true,
            },
            config = function()
                require("aw.ui.lualine")
            end,
        })

        use({
            "levouh/tint.nvim",
            config = function()
                require("tint").setup()
            end,
        })
        use({
            "kdheepak/tabline.nvim",
            config = function()
                require("aw.ui.tabline")
            end,
        })

        -- Add indentation guides even on blank lines
        use("lukas-reineke/indent-blankline.nvim")
        -- Add git related info in the signs columns and popups
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        })

        --              _
        --  _ __   ___ | |_ ___  ___
        -- | '_ \ / _ \| __/ _ \/ __|
        -- | | | | (_) | ||  __/\__ \
        -- |_| |_|\___/ \__\___||___/

        use({
            "quarto-dev/quarto-nvim",
            requires = { "neovim/nvim-lspconfig", "vim-pandoc/vim-pandoc-syntax" },
            ft = "quarto",
        })
        use({
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            ft = { "markdown", "vimwiki" },
        })
        use({
            "vimwiki/vimwiki",

            config = function()
                vim.cmd([[
                  let g:vimwiki_global_ext = 0

                  let main_wiki = {}
                  let main_wiki.path = '~/Documents/vimwiki/'
                  let main_wiki.syntax = 'markdown'
                  let main_wiki.ext = '.md'
                  let main_wiki.links_space_char = '_'

                  let writing_wiki = {}
                  let writing_wiki.path = '~/Documents/writing/'
                  let writing_wiki.syntax = 'markdown'
                  let writing_wiki.ext = '.md'
                  let writing_wiki.links_space_char = '_'

                  let g:vimwiki_list = [main_wiki, writing_wiki]
                ]])
            end,
        })
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})

--           _   _   _
--  ___  ___| |_| |_(_)_ __   __ _ ___
-- / __|/ _ \ __| __| | '_ \ / _` / __|
-- \__ \  __/ |_| |_| | | | | (_| \__ \
-- |___/\___|\__|\__|_|_| |_|\__, |___/
--                           |___/

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python"

--             _   _
--  ___  _ __ | |_(_) ___  _ __  ___
-- / _ \| '_ \| __| |/ _ \| '_ \/ __|
--| (_) | |_) | |_| | (_) | | | \__ \
-- \___/| .__/ \__|_|\___/|_| |_|___/
--      |_|

vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.autochdir = false
vim.opt.completeopt = { "menu", "preview", "noselect" }

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.opt.mouse = "a"

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- colors
vim.opt.termguicolors = true

-- _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- Keybindings work like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--

-- remap esc
vim.keymap.set("i", "jk", "<ESC>")

-- folding
vim.keymap.set("n", ",", "za", { noremap = true })

-- window switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<Leader>nh", "<Cmd>nohlsearch<CR>")

-- Make Y behave like the other capitals
vim.keymap.set("n", "Y", "y$")

-- insert the current date in long format
vim.keymap.set("n", "<Leader>d", ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

-- Make the buffer the only buffer on the screen
vim.keymap.set("n", "<Leader>o", "<cmd>only<CR>")

-- New Tab
vim.keymap.set("n", "<C-T>", "<cmd>tabnew<CR>")

-- cd to current file's directory
vim.keymap.set("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>", { noremap = true })

-- Not sure why this doesn't work in lua. Says something about invalid escape sequence.
-- It makes Escape get you into normal mode in a neovim terminal
vim.cmd([[
  tnoremap <Esc> <C-\><C-n>
]])

--vim.keymap.set("n", "<Leader>j", ":sp :belowright term<CR>")

-- This will clear when you hit ESC in normal mode
vim.keymap.set("n", "<Esc>", function()
    require("trouble").close()
    require("notify").dismiss() -- clear notifications
    vim.cmd.nohlsearch() -- clear highlights
    vim.cmd.echo() -- clear short-message

    require("nvim-terminal").DefaultTerminal:close()
end)

-- Reload config function
function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match("^aw") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!")
end
vim.keymap.set("n", "<Leader><Leader>r", "<Cmd>lua ReloadConfig()<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<Leader><Leader>s", "<Cmd>PackerSync<CR>", { noremap = true })

--           _
--  ___ ___ | | ___  _ __ ___
-- / __/ _ \| |/ _ \| '__/ __|
--| (_| (_) | | (_) | |  \__ \
-- \___\___/|_|\___/|_|  |___/

-- For everforest
-- vim.cmd [[colorscheme everforest]]

-- onedark
local onedark = require("onedark")
onedark.setup({
    style = "deep",
    transparent = false,
    ending_tildes = false,
    code_style = {
        comments = "none",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
    },
})
onedark.load()

-- _ __ ___ (_)___  ___
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__
-- |_| |_| |_|_|___/\___|

-- Highlight on yank
local yank_highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
    clear = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
    group = yank_highlight_group,
    pattern = "*",
})

-- Set backups
vim.cmd([[
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile
]])

-- Defines an "inspector" function for inspecting lua objects
function _G.put(...)
    local objects = {}
    for i = 1, select("#", ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, "\n"))
    return ...
end

require("aw.lsp")
