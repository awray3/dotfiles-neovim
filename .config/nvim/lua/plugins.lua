local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugged/")

-- === Generally great things ===
Plug("machakann/vim-highlightedyank")
Plug("tpope/vim-surround")
Plug("scrooloose/nerdcommenter")
Plug("knubie/vim-kitty-navigator", { ["do"] = "cp pass_keys.py neighboring_window.py ~/.config/kitty/" })

Plug("chentau/marks.nvim") -- sweet mark functionality
Plug("ggandor/lightspeed.nvim")
Plug("tpope/vim-obsession")

Plug("edluffy/specs.nvim") -- makes cursor jumps all wooshy

Plug("vimwiki/vimwiki") -- For notes

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter")
Plug("nvim-treesitter/playground")

-- fzf related awesomeness
Plug("nvim-lua/popup.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-telescope/telescope-project.nvim") -- investigate this one later
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug("crispgm/telescope-heading.nvim")

-- closes parens
Plug("jiangmiao/auto-pairs")

-- == LSP Setup ==
Plug("neovim/nvim-lspconfig")
Plug("williamboman/nvim-lsp-installer")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("lukas-reineke/lsp-format.nvim")

-- LSP-related: snippets
Plug("saadparwaiz1/cmp_luasnip")
Plug("L3MON4D3/LuaSnip")

-- === Git Plugins === --
-- Enable git changes to be shown in sign column
Plug("mhinz/vim-signify")
Plug("tpope/vim-fugitive")

-- === UI === --
-- File explorer
Plug("kyazdani42/nvim-web-devicons")
Plug("kyazdani42/nvim-tree.lua")
Plug("folke/trouble.nvim")

-- Customized vim status line
Plug("nvim-lualine/lualine.nvim")

-- Terminal and REPL
Plug("voldikss/vim-floaterm")
Plug("jpalardy/vim-slime")

-- === Color Themes ===
Plug("rktjmp/lush.nvim")
Plug("navarasu/onedark.nvim")
Plug("ellisonleao/gruvbox.nvim")

vim.call("plug#end")
