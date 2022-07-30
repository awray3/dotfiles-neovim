
-- setup packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'sainnhe/everforest'
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use "tpope/vim-surround"
  use {
      "preservim/nerdcommenter",
      config = function()
          vim.g.NERDCreateDefaultMappings = false
          vim.keymap.set("n", "<C-_>", "<Plug>NERDCommenterToggle")
          vim.keymap.set("v", "<C-_>", "<Plug>NERDCommenterToggle")
      end
      
  }
  use "knubie/vim-kitty-navigator"
  use 'williamboman/nvim-lsp-installer'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
end)


--          _   _   _                 
-- ___  ___| |_| |_(_)_ __   __ _ ___ 
--/ __|/ _ \ __| __| | '_ \ / _` / __|
--\__ \  __/ |_| |_| | | | | (_| \__ \
--|___/\___|\__|\__|_|_| |_|\__, |___/
--                          |___/     

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
--| | _____ _   _ _ __ ___   __ _ _ __  ___ 
--| |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
--|   <  __/ |_| | | | | | | (_| | |_) \__ \
--|_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--          |___/                |_|        

-- Works like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--
function FKeyBinding(file, Fkey)
  vim.keymap.set("n", Fkey, "<Cmd>luafile "..file.."<CR>")
end

-- maps the F keys to key config files
FKeyBinding("$HOME/.config/nvim/init.lua", "<F1>")
FKeyBinding("$HOME/.zshrc", "<F2>")
FKeyBinding("$HOME/.config/kitty/kitty.conf", "<F3>")
FKeyBinding("$HOME/.config/starship.toml", "<F4>")

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


--           _                
--  ___ ___ | | ___  _ __ ___ 
-- / __/ _ \| |/ _ \| '__/ __|
--| (_| (_) | | (_) | |  \__ \
-- \___\___/|_|\___/|_|  |___/
--                            
vim.g.everforest_background = 'soft'
vim.g.everforest_better_performance = 1
vim.opt.background = 'dark'
vim.cmd [[colorscheme everforest]]



-- _ __ ___ (_)___  ___ 
--| '_ ` _ \| / __|/ __|
--| | | | | | \__ \ (__ 
--|_| |_| |_|_|___/\___|

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
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

require("lsp")
require("tele-scope")
require("sitter")
require("tree")

