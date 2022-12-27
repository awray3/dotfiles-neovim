--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_  | | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|

--           _   _   _
--  ___  ___| |_| |_(_)_ __   __ _ ___
-- / __|/ _ \ __| __| | '_ \ / _` / __|
-- \__ \  __/ |_| |_| | | | | (_| \__ \
-- |___/\___|\__|\__|_|_| |_|\__, |___/
--                           |___/
-- general settings for neovim

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.python3_host_prog = '~/.config/nvim/.venv/bin/python'

-- disable jukit mappings
vim.cmd [[
    let g:jukit_mappings=0
]]

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

--  ____  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/

-- this is inherited from the launching process
local terminal_is_kitty = vim.env.TERM == 'xterm-kitty'
local is_neovide = vim.g.neovide

if is_neovide then
    require 'aw.neovide'
    terminal_is_kitty = false
elseif terminal_is_kitty then
    vim.notify 'Launching in Kitty Mode!'
else
    vim.notify 'Launching in Standard Mode!'
end

-- plugins table for lazy.nvim
local plugins = {
    --[[   
      ___ ___  _ __ ___
     / __/ _ \| '__/ _ \
    | (_| (_) | | |  __/
     \___\___/|_|  \___| ]]
    {
        dir=vim.fn.expand("~/.config/nvim/aw/lsp"),
        name = 'my-lsp-config',
        config = function()
            require 'aw.lsp'
        end,
    },

    --treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'aw.treesitter'
        end,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            { 'nvim-treesitter/playground' },
        },
    },

    --telescope
    {
        'nvim-telescope/telescope.nvim',
        requires = {
             'nvim-lua/plenary.nvim' ,
        }
    },

    --[[ 
      ____      _                
     / ___|___ | | ___  _ __ ___ 
    | |   / _ \| |/ _ \| '__/ __|
    | |__| (_) | | (_) | |  \__ \
     \____\___/|_|\___/|_|  |___/ ]]

    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup()
        end,
    },
    {
        'sainnhe/everforest',
        config = function()
            vim.g.everforest_background = 'soft'
            vim.g.everforest_better_performance = 1
            vim.g.everforest_disable_italic_comment = 1
            vim.opt.background = 'dark'
        end,
        lazy = true,
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'deep',
                transparent = false,
                ending_tildes = false,
                code_style = {
                    comments = 'none',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none',
                },
            }
        end,
        lazy = true,
    },
}

require('lazy').setup(plugins, {})

vim.cmd [[colorscheme nightfox]]
--require('packer').startup {

--         use {
--             'nvim-telescope/telescope.nvim',
--             requires = { 'nvim-lua/plenary.nvim' },
--             config = function()
--                 require 'aw.telescope'
--             end,
--         }
--
--         -- This uses a c implementation of fzf for telescope.
--         -- Very fast searching
--         use {
--             'nvim-telescope/telescope-fzf-native.nvim',
--             run = 'make',
--         }
--         use { 'nvim-telescope/telescope-file-browser.nvim' }
--
--         -- Plugin for interfacing with Github issues/PRs/etc
--         -- with a telescope selector
--         -- Something about Github and octopi?
--         use {
--             'pwntester/octo.nvim',
--             requires = {
--                 'nvim-lua/plenary.nvim',
--                 'nvim-telescope/telescope.nvim',
--                 'kyazdani42/nvim-web-devicons',
--             },
--             opt = true,
--             config = function()
--                 require 'aw.octo'
--             end,
--         }
--
--         -- a simple, flip open and close terminal just like vscode has.
--         use {
--             's1n7ax/nvim-terminal',
--             config = function()
--                 vim.o.hidden = true
--                 require('nvim-terminal').setup {
--                     toggle_keymap = '<leader>j',
--                 }
--             end,
--         }
--
--         -- repl plugin
--         use {
--             'luk400/vim-jukit',
--             ft = { 'julia', 'python' },
--             config = function()
--                 -- I want to define my own mappings for things I use. A lot of jukit's commands
--                 -- overwrite stuff I use.
--                 vim.cmd [[
--                     let g:jukit_mappings_ext_enabled = ""
--                 ]]
--
--                 -- function for getting the column names of the dataframe
--                 function _G.df_columns()
--                     local word_under_cursor = vim.fn.expand '<cword>'
--                     local cmd = 'list(' .. word_under_cursor .. '.columns' .. ')'
--                     -- might also be {cmd} or {cmd = cmd} if this doesn't work
--                     vim.fn['jukit#send#send_to_split'](cmd)
--                 end -- end df_cols
--
--                 local jukit_map = function(lhs, rhs, desc, mode)
--                     mode = mode or 'n'
--                     local ju_desc = 'JuKit: ' .. desc
--                     vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = ju_desc })
--                 end
--                 jukit_map('<Leader>dc', '<Cmd>lua df_columns()<CR>', '[D]ataframe [C]columns')
--
--                 ---------- Managing Jukit Windows
--
--                 -- Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
--                 jukit_map('<Leader>os', ':call jukit#splits#output()<cr>', '[O]utput [Split]')
--
--                 -- Opens a new output window without executing any command
--                 jukit_map('<Leader>ts', ':call jukit#splits#term()<cr>', '[T]erminal [Split]')
--
--                 -- Opens a new output-history window, where saved ipython outputs are displayed
--                 jukit_map('<Leader>hs', ':call jukit#splits#history()<cr>', '[H]i[S]tory')
--
--                 -- Opens a new output-history window, where saved ipython outputs are displayed
--                 jukit_map('<Leader>ohs', ':call jukit#splits#output_and_history()<cr>', '[O]utput and [H]i[S]tory')
--
--                 -- closes the history window
--                 jukit_map('<Leader>ch', ':call jukit#splits#close_history()<cr>', '[C]lose [H]istory')
--
--                 -- close the output window
--                 jukit_map('<Leader>co', ':call jukit#splits#close_output_split()<cr>', '[C]lose [Output] window')
--
--                 --------- Sending Code
--
--                 -- sends the current cell to output split
--                 jukit_map('<Leader>,', ':call jukit#send#section(0)<cr>', 'Send Selection')
--
--                 -- same, but keeps the cursor in the same cell
--                 jukit_map('<Leader><Leader>,', ':call jukit#send#section(1)<cr>', 'Send Selection')
--
--                 -- send a line
--                 jukit_map('<cr>', ':call jukit#send#line()<cr>', 'Send line')
--
--                 -- send selection
--                 jukit_map('<cr>', ':call jukit#send#selection()<cr>', 'Send Selection', 'v')
--
--                 -- send all cells
--                 jukit_map('<Leader>all', ':call jukit#send#all()<cr>', 'Send all cells')
--
--                 if terminal_is_kitty and not is_neovide then
--                     vim.g.jukit_terminal = 'kitty'
--                     vim.g.jukit_output_new_os_window = 1
--                     vim.g.jukit_mpl_style = vim.fn['jukit#util#plugin_path'] {} .. '/helpers/matplotlib-backend-kitty/backend.mplstyle'
--                     vim.g.jukit_inline_plotting = 1
--                 else
--                     vim.g.jukit_mpl_style = ''
--                     vim.g.jukit_inline_plotting = 0
--                 end -- endif
--             end, -- end jukit configuration
--         }
--
--         -- debugging
--         use { 'mfussenegger/nvim-dap', ft = { 'python', 'java' }, opt = true }
--
--         use 'tpope/vim-surround'
--
--         -- Detect tabstop and shiftwidth automatically
--         use 'tpope/vim-sleuth'
--
--         use {
--             'numToStr/Comment.nvim',
--             config = function()
--                 require('Comment').setup {
--                     padding = true,
--                     sticky = true,
--                     toggler = {
--                         line = '<leader>=',
--                         block = '<leader>-',
--                     },
--                     opleader = {
--                         ---Line-comment keymap
--                         line = '<leader>=',
--                         ---Block-comment keymap
--                         block = '<leader>-',
--                     },
--                     ---LHS of extra mappings
--                     extra = {
--                         ---Add comment on the line above
--                         above = 'gcO',
--                         ---Add comment on the line below
--                         below = 'gco',
--                         ---Add comment at the end of line
--                         eol = 'gcA',
--                     },
--                     ---Enable keybindings
--                     ---NOTE: If given `false` then the plugin won't create any mappings
--                     mappings = {
--                         ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
--                         basic = true,
--                         ---Extra mapping; `gco`, `gcO`, `gcA`
--                         extra = true,
--                     },
--                 }
--             end, -- end comment.nvim configuration
--         }
--
--         -- makes jk and jj work better
--         use {
--             'max397574/better-escape.nvim',
--             config = function()
--                 require('better_escape').setup {
--                     keys = function()
--                         return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
--                     end,
--                 }
--             end,
--         }
--
--         use {
--             'knubie/vim-kitty-navigator',
--             cond = terminal_is_kitty and not is_neovide,
--             -- integration with kitty terminal
--         }
--
--         -- makes parenthesis matching better
--         use {
--             'windwp/nvim-autopairs',
--             config = function()
--                 local autopairs = require 'nvim-autopairs'
--                 autopairs.setup {}
--                 autopairs.remove_rule '`'
--             end,
--         }
--
--         -- makes scrolling smoother
--         use {
--             'declancm/cinnamon.nvim',
--             config = function()
--                 require('cinnamon').setup {
--                     extra_keymaps = true,
--                 }
--             end,
--         }
--
--         -- A nice way to view diagnostics and workspace problems
--         use {
--             'folke/trouble.nvim',
--             requires = 'kyazdani42/nvim-web-devicons',
--             config = function()
--                 require('trouble').setup {}
--             end,
--         }
--
--         -- Nice centering
--         use {
--             'shortcuts/no-neck-pain.nvim',
--             tag = '*',
--             config = function()
--                 require('no-neck-pain').setup()
--                 vim.keymap.set('n', '<leader>nn', '<Cmd>NoNeckPain<CR>', { silent = true, noremap = true, desc = 'Toggle no neck pain' })
--             end,
--         }
--         --  _     ____  ____
--         -- | |   / ___||  _ \
--         -- | |   \___ \| |_) |
--         -- | |___ ___) |  __/
--         -- |_____|____/|_|
--
--         use {
--             'neovim/nvim-lspconfig',
--             requires = {
--                 -- Automatically install LSPs to stdpath for neovim
--                 'williamboman/mason.nvim',
--                 'williamboman/mason-lspconfig.nvim',
--
--                 -- Useful status updates for LSP
--                 'j-hui/fidget.nvim',
--             },
--         }
--
--         use {
--             'jose-elias-alvarez/null-ls.nvim',
--             requires = { 'nvim-lua/plenary.nvim' },
--         }
--
--         use {
--             'hrsh7th/cmp-nvim-lsp',
--             'hrsh7th/cmp-buffer',
--             'hrsh7th/cmp-path',
--             'hrsh7th/cmp-cmdline',
--             'hrsh7th/nvim-cmp',
--         }
--
--         use { 'L3MON4D3/LuaSnip' }
--
--         --  _   _ ___
--         -- | | | |_ _|
--         -- | | | || |
--         -- | |_| || |
--         --  \___/|___|
--
--         -- colorschemes
--
--         use {
--             'sainnhe/everforest',
--             config = function()
--                 vim.g.everforest_background = 'soft'
--                 vim.g.everforest_better_performance = 1
--                 vim.g.everforest_disable_italic_comment = 1
--                 vim.opt.background = 'dark'
--             end,
--         }
--         -- use 'safv12/andromeda.vim'
--
--         -- Nice bottom-line
--         use {
--             'nvim-lualine/lualine.nvim',
--             requires = {
--                 'kyazdani42/nvim-web-devicons',
--                 opt = true,
--             },
--             config = function()
--                 require 'aw.ui.lualine'
--             end,
--         }
--
--         -- Tints non-focused buffers, making it easier
--         -- to identify the currently active buffer
--         use {
--             'levouh/tint.nvim',
--             config = function()
--                 require('tint').setup {}
--             end,
--         }
--
--         -- Nice top line
--         use {
--             'kdheepak/tabline.nvim',
--             config = function()
--                 require 'aw.ui.tabline'
--             end,
--         }
--
--         -- Add indentation guides even on blank lines
--         use 'lukas-reineke/indent-blankline.nvim'
--         -- Add git related info in the signs columns and popups
--
--         -- Git related plugins
--         use 'tpope/vim-fugitive'
--         use 'tpope/vim-rhubarb'
--         use { 'lewis6991/gitsigns.nvim', tag = 'release' }
--
--         use {
--             'rcarriga/nvim-notify',
--             config = function()
--                 vim.notify = require 'notify'
--             end,
--         }
--
--         -- syntax for justfiles
--         use { 'NoahTheDuke/vim-just', ft = { 'just' } }
--
--         --              _
--         --  _ __   ___ | |_ ___  ___
--         -- | '_ \ / _ \| __/ _ \/ __|
--         -- | | | | (_) | ||  __/\__ \
--         -- |_| |_|\___/ \__\___||___/
--
--         -- main plugin for Quarto.
--         -- https://quarto.org/
--         use {
--             'quarto-dev/quarto-nvim',
--             requires = { 'neovim/nvim-lspconfig' },
--             ft = 'quarto',
--             config = function()
--                 require('quarto').setup {
--                     debug = false,
--                     lspFeatures = {
--                         enabled = true,
--                         languages = { 'r', 'python', 'julia' },
--                         diagnostics = {
--                             enabled = true,
--                             triggers = { 'BufEnter', 'InsertLeave', 'TextChanged' },
--                         },
--                         cmpSource = {
--                             enabled = true,
--                         },
--                     },
--                     keymap = {
--                         hover = 'K',
--                     },
--                 }
--             end,
--         }
--
--         -- If you need a quick Markdown Viewer
--         use {
--             'iamcco/markdown-preview.nvim',
--             run = function()
--                 vim.fn['mkdp#util#install']()
--             end,
--             ft = { 'markdown', 'vimwiki', 'quarto' },
--         }
--
--         -- great for clearing out a buffer while leaving the window itself
--         use {
--             'famiu/bufdelete.nvim',
--             config = function()
--                 vim.keymap.set('n', '<Leader>q', function()
--                     require('bufdelete').bufdelete(0, true)
--                 end, {
--                     noremap = true,
--                     silent = true,
--                     desc = 'Delete buffer',
--                 })
--             end,
--         }
--
--         -- removes legacy neotree commands.
--         vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
--         use {
--             'nvim-neo-tree/neo-tree.nvim',
--             branch = 'v2.x',
--             requires = {
--                 'nvim-lua/plenary.nvim',
--                 'kyazdani42/nvim-web-devicons',
--                 'MunifTanjim/nui.nvim',
--             },
--             config = function()
--                 require('neo-tree').setup {}
--
--                 local opts = {noremap=true, silent=true}
--                 vim.keymap.set("n", "<C-n>", "<Cmd>Neotree<CR>", opts)
--                 vim.keymap.set("n", "<Leader>gs", "<Cmd>Neotree git_status<CR>", opts)
--                 vim.keymap.set("n", "<Leader>gb", "<Cmd>Neotree buffers<CR>", opts)
--             end,
--         }
--
--         -- GPT-3 code completion
--         use {
--             'dense-analysis/neural',
--             config = function()
--                 local read_api_key = function()
--                     local cred_file = vim.fn.expand '~/.openai/credentials'
--                     local fp = io.open(cred_file)
--
--                     local api_key = fp:read '*l'
--                     fp:close()
--
--                     return api_key
--                 end
--
--                 require('neural').setup {
--                     open_ai = {
--                         api_key = read_api_key(),
--                     },
--                 }
--             end,
--             requires = {
--                 'MunifTanjim/nui.nvim',
--                 'ElPiloto/significant.nvim',
--             },
--         }
--
--         -- Great for quick notes or journaling
--         use {
--             'vimwiki/vimwiki',
--
--             config = function()
--                 vim.cmd [[
--                   let g:vimwiki_global_ext = 0
--
--                   let main_wiki = {}
--                   let main_wiki.path = '~/Documents/vimwiki/'
--                   let main_wiki.syntax = 'markdown'
--                   let main_wiki.ext = '.md'
--                   let main_wiki.links_space_char = '_'
--
--                   let writing_wiki = {}
--                   let writing_wiki.path = '~/Documents/writing/'
--                   let writing_wiki.syntax = 'markdown'
--                   let writing_wiki.ext = '.md'
--                   let writing_wiki.links_space_char = '_'
--
--                   let g:vimwiki_list = [main_wiki, writing_wiki]
--                 ]]
--             end,
--         }
--
--         if is_bootstrap then
--             require('packer').sync()
--         end
--     end,
--
--     -- this makes packer display as a floating window instead
--     -- of a buffer to the side.
--     config = {
--         display = {
--             open_fn = require('packer.util').float,
--         },
--     },
-- }

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
--[[ local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
}) ]]

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
vim.opt.autochdir = false
--vim.opt.completeopt = { 'menu', 'preview', 'noselect' }
vim.opt.completeopt = 'menuone,noselect'

-- folds
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
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

vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- Keybindings in lua work like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--

-- this makes the arrow keys scroll the screen instead
-- of the cursor. Hold shift to go back to cursor.
vim.cmd [[
        map <Down> <C-E>
        map <Up> <C-Y>
        map <S-Down> j
        map <S-Up> k
    ]]

--Clear space so that leader can use it? Is this necessary?
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- folding
vim.keymap.set('n', ',', 'za', { noremap = true })

-- window switching
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Make Y behave like the other capitals
vim.keymap.set('n', 'Y', 'y$')

-- insert the current date in long format
vim.keymap.set('n', '<Leader>da', ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

-- Make the buffer the only buffer on the screen
vim.keymap.set('n', '<Leader>o', '<cmd>only<CR>')

-- New Tab
vim.keymap.set('n', '<C-T>', '<cmd>tabnew<CR>')

-- cd to current file's directory
vim.keymap.set('n', '<Leader><Leader>cd', '<Cmd>cd %:p:h<CR>', { noremap = true })

-- It makes Escape get you into normal mode in a neovim terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- This will clear things when you hit ESC in normal mode.
vim.keymap.set('n', '<Esc>', function()
    require('trouble').close()
    require('notify').dismiss {} -- clear notifications
    vim.cmd.nohlsearch() -- clear highlights
    vim.cmd.echo() -- clear short-message
end)

-- Reload config function. It will:
-- clear loaded submodules in the $NEOHOME/lua folder (ensuring they reload);
-- stop all lsp clients;
-- resource init.lua and all lua submodules as needed.
function _G.ReloadConfig()
    -- clear any loaded packages, so submodules refresh with config refresh.
    for name, _ in pairs(package.loaded) do
        if name:match '^aw' then
            package.loaded[name] = nil
        end
    end

    -- stop all clients.
    vim.notify 'Stopping All Lsp Clients...'
    vim.lsp.stop_client(vim.lsp.get_active_clients(), false)

    vim.notify 'Sourcing $NEOHOME/init.lua...'
    dofile(vim.env.MYVIMRC)
    vim.notify 'Nvim configuration reloaded!'
end

vim.keymap.set('n', '<Leader><Leader>r', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<Leader><Leader>s', '<Cmd>PackerSync<CR>', { noremap = true })

--           _
--  ___ ___ | | ___  _ __ ___
-- / __/ _ \| |/ _ \| '__/ __|
--| (_| (_) | | (_) | |  \__ \
-- \___\___/|_|\___/|_|  |___/

-- For everforest
-- vim.cmd [[colorscheme everforest]]

-- onedark
--[[ local onedark = require 'onedark'
onedark.setup {
    style = 'deep',
    transparent = false,
    ending_tildes = false,
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
    },
}
onedark.load() ]]

-- nightfox
require('nightfox').setup()
vim.cmd [[colorscheme nightfox]]

-- _ __ ___ (_)___  ___
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__
-- |_| |_| |_|_|___/\___|

-- Highlight on yank
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true,
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank {
            timeout = 300,
        }
    end,
    group = yank_highlight_group,
    pattern = '*',
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

-- Defines an "inspector" function for inspecting lua objects
function _G.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end
