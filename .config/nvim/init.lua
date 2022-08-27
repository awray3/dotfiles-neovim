--  _       _ _     _             
-- (_)_ __ (_) |_  | |_   _  __ _ 
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|

-- bootstrap and setup packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', {
    clear = true
})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = 'init.lua'
})

--  ____  _             _           
-- |  _ \| |_   _  __ _(_)_ __  ___ 
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/             

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
                    
    --   ___ ___  _ __ ___ 
    --  / __/ _ \| '__/ _ \
    -- | (_| (_) | | |  __/
    --  \___\___/|_|  \___|
                    

    use 'nvim-treesitter/nvim-treesitter'
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use "tpope/vim-surround"
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons' -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        "preservim/nerdcommenter",
        config = function()
            vim.g.NERDCreateDefaultMappings = false
            vim.keymap.set("n", "<C-_>", "<Plug>NERDCommenterToggle")
            vim.keymap.set("v", "<C-_>", "<Plug>NERDCommenterToggle")
        end
    }
    use "knubie/vim-kitty-navigator"

    --  _     ____  ____  
    -- | |   / ___||  _ \ 
    -- | |   \___ \| |_) |
    -- | |___ ___) |  __/ 
    -- |_____|____/|_|    

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'williamboman/nvim-lsp-installer'

    --  _   _ ___ 
    -- | | | |_ _|
    -- | | | || | 
    -- | |_| || | 
    --  \___/|___|
            

    -- colorschemes
    use 'sainnhe/everforest'
    use 'safv12/andromeda.vim'
    use 'navarasu/onedark.nvim'

    -- lines
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {
                        left = "",
                        right = ""
                    },
                    section_separators = {
                        left = "",
                        right = ""
                    },
                    disabled_filetypes = {},
                    always_divide_middle = true
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff", {
                        "diagnostics",
                        sources = {"nvim_diagnostic"}
                    }},
                    lualine_c = {"filename"},
                    lualine_x = {"filetype", "fileformat"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {"filename"},
                    lualine_x = {"location"},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {'nvim-tree'}
            })
        end
    }
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                -- Defaults configuration options
                enable = true,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = false -- this shows only tabs instead of tabs + buffers
                }
            }
            vim.cmd [[
            set guioptions-=e " Use showtabline in gui vim
            set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]]
        end,
        requires = {{
            'nvim-lualine/lualine.nvim',
            opt = true
        }, {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }}
    }
    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }

    --              _            
    --  _ __   ___ | |_ ___  ___ 
    -- | '_ \ / _ \| __/ _ \/ __|
    -- | | | | (_) | ||  __/\__ \
    -- |_| |_|\___/ \__\___||___/

    use({
        "quarto-dev/quarto-vim",
        requires = {{"vim-pandoc/vim-pandoc-syntax"}},
        ft = {"quarto"}
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = {"markdown"}
    })
    use({"vimwiki/vimwiki"})
end)

--          _   _   _                 
-- ___  ___| |_| |_(_)_ __   __ _ ___ 
-- / __|/ _ \ __| __| | '_ \ / _` / __|
-- \__ \  __/ |_| |_| | | | | (_| \__ \
-- |___/\___|\__|\__|_|_| |_|\__, |___/
--                          |___/     

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python"

--             _   _                 
--  ___  _ __ | |_(_) ___  _ __  ___ 
-- / _ \| '_ \| __| |/ _ \| '_ \/ __|
-- | (_) | |_) | |_| | (_) | | | \__ \
-- \___/| .__/ \__|_|\___/|_| |_|___/
--      |_|                          

vim.opt.hidden = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.autochdir = true
vim.opt.completeopt = {'menu', 'preview', 'noselect'}

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 3

vim.opt.mouse = 'a'

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'

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
--          |___/                |_|        

-- Keybindings work like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--

-- function for making an Fkey binding for a file. 
-- opens the file in a new tab.
function FKeyBinding(file, Fkey)
    vim.keymap.set("n", Fkey, "<Cmd>tabnew " .. file .. "<CR>")
end

-- maps the F keys to key config files
FKeyBinding("$HOME/.config/nvim/init.lua", "<F1>")
FKeyBinding("$HOME/.zshrc", "<F2>")
FKeyBinding("$HOME/.config/kitty/kitty.conf", "<F3>")
FKeyBinding("$HOME/.config/starship.toml", "<F4>")
FKeyBinding("$HOME/Documents/vimwiki", "<F5>")

-- remap esc
vim.keymap.set("i", "jk", "<ESC>")

-- folding
vim.keymap.set("n", ",", "za")

-- window switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<Leader>/", "<Cmd>nohlsearch<CR>")

-- telescope search-under-word
vim.keymap.set("n", "#", "<Cmd>Telescope grep_string<CR>")

-- Make Y behave like the other capitals
vim.keymap.set("n", "Y", "y$")

-- insert the current date in long format
vim.keymap.set("n", "<Leader>d", ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

--           _                
--  ___ ___ | | ___  _ __ ___ 
-- / __/ _ \| |/ _ \| '__/ __|
-- | (_| (_) | | (_) | |  \__ \
-- \___\___/|_|\___/|_|  |___/

-- For everforest
-- vim.g.everforest_background = 'soft'
-- vim.g.everforest_better_performance = 1
-- vim.opt.background = 'dark'
-- vim.cmd [[colorscheme everforest]]

-- onedark
local onedark = require('onedark')
onedark.setup({
    style = 'deep',
    transparent = true,
    ending_tildes = false,
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    }
})
onedark.load()

-- _ __ ___ (_)___  ___ 
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__ 
-- |_| |_| |_|_|___/\___|

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            timeout = 300
        })
    end,
    group = highlight_group,
    pattern = '*'
})

-- Set backups
vim.cmd [[
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

]]

require("lsp")
require("tele-scope")
require("sitter")
require("tree")
require("notes")
