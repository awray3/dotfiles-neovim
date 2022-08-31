--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_  | | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
-- bootstrap and setup packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

--local packer_group = vim.api.nvim_create_augroup('Packer', {
--    clear = true
--})
--vim.api.nvim_create_autocmd('BufWritePost', {
--    command = 'source <afile> | PackerCompile',
--    group = packer_group,
--    pattern = 'init.lua'
--})

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
    use 'nvim-treesitter/playground'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    use "tpope/vim-surround"
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        tag = 'nightly'
    }
    use {
        "preservim/nerdcommenter",
        config = function()
            vim.g.NERDCreateDefaultMappings = false
            vim.keymap.set("n", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = true })
            vim.keymap.set("v", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = true })
        end
    }
    use "knubie/vim-kitty-navigator"

    use { 'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 100
        end
    }

    --  _     ____  ____
    -- | |   / ___||  _ \
    -- | |   \___ \| |_) |
    -- | |___ ___) |  __/
    -- |_____|____/|_|

    use {
        "neovim/nvim-lspconfig",
    }

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    -- use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'williamboman/nvim-lsp-installer'

    --  _   _ ___
    -- | | | |_ _|
    -- | | | || |
    -- | |_| || |
    --  \___/|___|

    -- colorschemes
    use { 'sainnhe/everforest',
        config = function()
            vim.g.everforest_background = 'soft'
            vim.g.everforest_better_performance = 1
            vim.g.everforest_disable_italic_comment = 1
            vim.opt.background = 'dark'
        end
    }
    -- use 'safv12/andromeda.vim'
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
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", {
                        "diagnostics",
                        sources = { "nvim_diagnostic" }
                    } },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype", "fileformat" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = { 'nvim-tree' }
            })
        end
    }
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require 'tabline'.setup {
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
        requires = { {
            'nvim-lualine/lualine.nvim',
            opt = true
        }, {
            'kyazdani42/nvim-web-devicons',
            opt = true
        } }
    }
    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    --              _
    --  _ __   ___ | |_ ___  ___
    -- | '_ \ / _ \| __/ _ \/ __|
    -- | | | | (_) | ||  __/\__ \
    -- |_| |_|\___/ \__\___||___/

    use({
        "quarto-dev/quarto-vim",
        requires = { { "vim-pandoc/vim-pandoc-syntax" } },
        ft = { "quarto" }
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown", "vimwiki" }
    })
    use({ "vimwiki/vimwiki" })
end)

--           _   _   _
--  ___  ___| |_| |_(_)_ __   __ _ ___
-- / __|/ _ \ __| __| | '_ \ / _` / __|
-- \__ \  __/ |_| |_| | | | | (_| \__ \
-- |___/\___|\__|\__|_|_| |_|\__, |___/
--                           |___/

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python"

--             _   _
--  ___  _ __ | |_(_) ___  _ __  ___
-- / _ \| '_ \| __| |/ _ \| '_ \/ __|
--| (_) | |_) | |_| | (_) | | | \__ \
-- \___/| .__/ \__|_|\___/|_| |_|___/
--      |_|

vim.opt.hidden = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.autochdir = false
vim.opt.completeopt = { 'menu', 'preview', 'noselect' }

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

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
--           |___/                |_|

-- Keybindings work like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--

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


-- Make Y behave like the other capitals
vim.keymap.set("n", "Y", "y$")

-- insert the current date in long format
vim.keymap.set("n", "<Leader>d", ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

-- Make the buffer the only buffer on the screen
vim.keymap.set("n", "<Leader>o", "<cmd>only<CR>")

vim.keymap.set("n", "<C-T>", "<cmd>tabnew<CR>")

--           _
--  ___ ___ | | ___  _ __ ___
-- / __/ _ \| |/ _ \| '__/ __|
--| (_| (_) | | (_) | |  \__ \
-- \___\___/|_|\___/|_|  |___/

-- For everforest
-- vim.cmd [[colorscheme everforest]]

-- onedark
local onedark = require('onedark')
onedark.setup({
    style = 'deep',
    transparent = false,
    ending_tildes = false,
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    }
})
onedark.load()

-- _     ____  ____
--| |   / ___||  _ \
--| |   \___ \| |_) |
--| |___ ___) |  __/
--|_____|____/|_|
-- anguage erver rotocol
local lspconfig = require("lspconfig")

-- global diagnostics configuration
vim.diagnostic.config({
    virtual_text = false
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>Nd', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>nd', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)


    -- null-ls formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.formatting_sync()
            end,
        })
    end

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts_callback = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(opts_callback)
        end
    })


end

-- Lua Language Server
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "bufnr" },
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2"
                }
            }
        }
    }
})

lspconfig.pyright.setup({
    on_attach = on_attach
})

-- null-ls setup
local null_ls = require("null-ls")

null_ls.setup({
    debug = false,
    on_attach = on_attach,
    sources = {
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettierd.with({
            env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc.yml") }
        }),
        null_ls.builtins.diagnostics.zsh,

    }
})


-- _____    _
--|_   _|__| | ___  ___  ___ ___  _ __   ___
--  | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
--  | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  |_|\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
--  The tool for searching things

local telescope = require("telescope")
local telescope_opts = { noremap = true, silent = true }

local telescope_bindings = {
    [""] = "builtin",
    f = "file_browser",
    g = "live_grep",
    b = "buffers",
    h = "help_tags",
    j = "jump_list",
    s = "current_buffer_fuzzy_find",
    m = "man_pages",
    r = "lsp_references",
    d = "lsp_definitions",
    c = "colorscheme"
}

-- telescope search-under-word (replaces default # action)
vim.keymap.set("n", "#", "<Cmd>Telescope grep_string<CR>")

for postfix_key, cmd in pairs(telescope_bindings) do
    vim.keymap.set("n", "<leader>t" .. postfix_key, "<cmd>Telescope " .. cmd .. " theme=ivy<CR>", telescope_opts)
end


local open_dotfiles = function(cwd)
    return function()
        require("telescope.builtin").find_files({
            cwd = cwd,
            theme = require("telescope.themes").get_ivy()
        })
    end
end

vim.keymap.set("n", "<leader>tn", open_dotfiles("$NEOHOME"), telescope_opts)
vim.keymap.set("n", "<leader>tz", open_dotfiles("$ZSH"), telescope_opts)


telescope.setup({
    defaults = {
        path_display = { shorten = 2 },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true
        }
    }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- _____                   _ _   _
--|_   _| __ ___  ___  ___(_) |_| |_ ___ _ __
--  | || '__/ _ \/ _ \/ __| | __| __/ _ \ '__|
--  | || | |  __/  __/\__ \ | |_| ||  __/ |
--  |_||_|  \___|\___||___/_|\__|\__\___|_|

local treesitter = require("nvim-treesitter.configs")
treesitter.setup({
    ensure_installed = {
        "bash",
        "comment",
        "python",
        "json",
        "lua",
        "yaml",
        "vim",
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
})

-- _ __ ___ (_)___  ___
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__
-- |_| |_| |_|_|___/\___|

-- Highlight on yank
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            timeout = 300
        })
    end,
    group = yank_highlight_group,
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

-- require("lsp")
--require("tele-scope")
--require("sitter")
--require("tree")
require("notes")
