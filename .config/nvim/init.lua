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
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[ packadd packer.nvim ]]
end

--  ____  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/

local terminal_is_kitty = vim.env.TERM == 'xterm-kitty'

require('packer').startup {
    function(use)
        use 'wbthomason/packer.nvim' -- Package manager

        --   ___ ___  _ __ ___
        --  / __/ _ \| '__/ _ \
        -- | (_| (_) | | |  __/
        --  \___\___/|_|  \___|

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require 'aw.treesitter'
            end,
        }
        -- Additional textobjects for treesitter
        use 'nvim-treesitter/nvim-treesitter-textobjects'
        use 'nvim-treesitter/playground'

        use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require 'aw.telescope'
            end,
        }
        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
        }
        use { 'nvim-telescope/telescope-file-browser.nvim' }
        use {
            'pwntester/octo.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope.nvim',
                'kyazdani42/nvim-web-devicons',
            },
            config = function()
                require 'aw.octo'
            end,
            -- Notes: this is for adding Github issues to my telescope selector
        }
        use {
            's1n7ax/nvim-terminal',
            config = function()
                vim.o.hidden = true
                require('nvim-terminal').setup {
                    toggle_keymap = '<leader>j',
                }
            end,
            -- a simple, flip open and close terminal just like vscode has.
        }
        use 'tpope/vim-surround'
        use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup {
                    padding = true,
                    sticky = true,
                    toggler = {
                        line = 'gcc',
                        block = 'gbc', --
                    },
                    opleader = {
                        ---Line-comment keymap
                        line = 'gc',
                        ---Block-comment keymap
                        block = 'gb',
                    },
                    ---LHS of extra mappings
                    extra = {
                        ---Add comment on the line above
                        above = 'gcO',
                        ---Add comment on the line below
                        below = 'gco',
                        ---Add comment at the end of line
                        eol = 'gcA',
                    },
                    ---Enable keybindings
                    ---NOTE: If given `false` then the plugin won't create any mappings
                    mappings = {
                        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                        basic = true,
                        ---Extra mapping; `gco`, `gcO`, `gcA`
                        extra = true,
                    },
                }
            end,
        }

        if terminal_is_kitty then
            use 'knubie/vim-kitty-navigator'
        end

        use {
            'windwp/nvim-autopairs',
            config = function()
                local autopairs = require 'nvim-autopairs'
                autopairs.setup {}
                autopairs.remove_rule '`'
            end,
        }

        -- makes scrolling smoother
        use {
            'declancm/cinnamon.nvim',
            config = function()
                require('cinnamon').setup {
                    extra_keymaps = true,
                }
            end,
        }

        -- Lua
        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require('trouble').setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end,
        }
        --  _     ____  ____
        -- | |   / ___||  _ \
        -- | |   \___ \| |_) |
        -- | |___ ___) |  __/
        -- |_____|____/|_|

        use {
            'neovim/nvim-lspconfig',
            requires = {
                -- Automatically install LSPs to stdpath for neovim
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',

                -- Useful status updates for LSP
                'j-hui/fidget.nvim',
            },
        }

        use {
            'jose-elias-alvarez/null-ls.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
        }

        use {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
        }

        use { 'L3MON4D3/LuaSnip' }

        use {
            'mfussenegger/nvim-dap',
            config = function()
                require 'aw.nvim-dap'
            end,
            --requires = {
            --"mfussenegger/nvim-dap-python",
            --}
        }

        --  _   _ ___
        -- | | | |_ _|
        -- | | | || |
        -- | |_| || |
        --  \___/|___|

        -- colorschemes
        use {
            'sainnhe/everforest',
            config = function()
                vim.g.everforest_background = 'soft'
                vim.g.everforest_better_performance = 1
                vim.g.everforest_disable_italic_comment = 1
                vim.opt.background = 'dark'
            end,
        }
        -- use 'safv12/andromeda.vim'
        use 'navarasu/onedark.nvim'

        -- lines
        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true,
            },
            config = function()
                require 'aw.ui.lualine'
            end,
        }

        use {
            'levouh/tint.nvim',
            config = function()
                require('tint').setup({})
            end,
        }

        use {
            'kdheepak/tabline.nvim',
            config = function()
                require 'aw.ui.tabline'
            end,
        }

        -- Add indentation guides even on blank lines
        use 'lukas-reineke/indent-blankline.nvim'
        -- Add git related info in the signs columns and popups

        -- Git related plugins
        use 'tpope/vim-fugitive'
        use 'tpope/vim-rhubarb'
        use { 'lewis6991/gitsigns.nvim', tag = 'release' }

        use {
            'rcarriga/nvim-notify',
            config = function()
                vim.notify = require 'notify'
            end,
        }

        --              _
        --  _ __   ___ | |_ ___  ___
        -- | '_ \ / _ \| __/ _ \/ __|
        -- | | | | (_) | ||  __/\__ \
        -- |_| |_|\___/ \__\___||___/

        use {
            'quarto-dev/quarto-nvim',
            requires = { 'neovim/nvim-lspconfig', 'vim-pandoc/vim-pandoc-syntax' },
            ft = 'quarto',
        }
        use {
            'iamcco/markdown-preview.nvim',
            run = function()
                vim.fn['mkdp#util#install']()
            end,
            ft = { 'markdown', 'vimwiki' },
        }
        use {
            'vimwiki/vimwiki',

            config = function()
                vim.cmd [[
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
                ]]
            end,
        }

        if is_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    },
}

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

--           _   _   _
--  ___  ___| |_| |_(_)_ __   __ _ ___
-- / __|/ _ \ __| __| | '_ \ / _` / __|
-- \__ \  __/ |_| |_| | | | | (_| \__ \
-- |___/\___|\__|\__|_|_| |_|\__, |___/
--                           |___/

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.python3_host_prog = '~/.config/nvim/.venv/bin/python'

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

-- Keybindings work like this:
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--

vim.cmd [[
        map <Down> <C-E>
        map <Up> <C-Y>
        map <S-Down> j
        map <S-Up> k
    ]]

--Clear space so that leader can use it
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- remap esc
vim.keymap.set('i', 'jk', '<ESC>')

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
vim.keymap.set('n', '<Leader>d', ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

-- Make the buffer the only buffer on the screen
vim.keymap.set('n', '<Leader>o', '<cmd>only<CR>')

-- New Tab
vim.keymap.set('n', '<C-T>', '<cmd>tabnew<CR>')

-- cd to current file's directory
vim.keymap.set('n', '<Leader>cd', '<Cmd>cd %:p:h<CR>', { noremap = true })

-- Not sure why this doesn't work in lua. Says something about invalid escape sequence.
-- It makes Escape get you into normal mode in a neovim terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap=true})
--vim.cmd [[
--  tnoremap <Esc> <C-\><C-n>
--]]

--vim.keymap.set("n", "<Leader>j", ":sp :belowright term<CR>")

-- This will clear when you hit ESC in normal mode
vim.keymap.set('n', '<Esc>', function()
    require('trouble').close()
    require('notify').dismiss() -- clear notifications
    vim.cmd.nohlsearch() -- clear highlights
    vim.cmd.echo() -- clear short-message

    require('nvim-terminal').DefaultTerminal:close()
end)

-- Reload config function
function _G.ReloadConfig()
    -- clear any loaded packages, so submodules refresh with config refresh.
    for name, _ in pairs(package.loaded) do
        if name:match '^aw' then
            package.loaded[name] = nil
        end
    end
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
local onedark = require 'onedark'
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
onedark.load()

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

-- Temporarily disabling so to use mason.
-- require 'aw.lsp'
--#region
--#region
-- _     ____  ____
--| |   / ___||  _ \
--| |   \___ \| |_) |
--| |___ ___) |  __/
--|_____|____/|_|
-- anguage erver rotocol
-- tags: LSP, lsp, language server protocos

local function define_signs()
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
end
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- Mason setup
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }


-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- Turn on lsp status information
require('fidget').setup()


-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- Completion is setup here
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
