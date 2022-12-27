--[[ 
| | _____ _   _ _ __ ___   __ _ _ __  ___
| |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
|   <  __/ |_| | | | | | | (_| | |_) \__ \
|_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
          |___/                |_|        ]]

-- Keybindings in lua work like this, since I always forget x)
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

-- this makes the arrow keys scroll the screen instead
-- of the cursor. Hold shift to go back to cursor.

local wk = require("which-key")
local utils = require("utils")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- I think this is a warning that you're repeating
-- these keys too much
for _, key in ipairs({ "h", "j", "k", "l" }) do
  local count = 0
  vim.keymap.set("n", key, function()
    if count >= 10 then
      id = vim.notify("Hold it Cowboy!", vim.log.levels.WARN, {
        icon = "🤠",
        replace = id,
        keep = function()
          return count >= 10
        end,
      })
    else
      count = count + 1
      vim.defer_fn(function()
        count = count - 1
      end, 5000)
      return key
    end
  end, { expr = true })
end

--Clear space so that leader can use it? Is this necessary?
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- folding
vim.keymap.set('n', ',', 'za', { noremap = true })

-- window switching
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Scroll window with up/down keys
vim.keymap.set("n", "<Up>", "<C-Y>")
vim.keymap.set("n", "<Down>", "<C-E>")

-- flip buffer with left right
vim.keymap.set("n", "<Left>", "<cmd>tabp<cr>")
vim.keymap.set("n", "<Right>", "<cmd>tabn<CR>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Make Y behave like the other capitals
vim.keymap.set('n', 'Y', 'y$')

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- insert the current date in long format
-- vim.keymap.set('n', '<Leader>da', ":0r!date +'\\%A, \\%B \\%d, \\%Y'<CR>")

-- Make the buffer the only buffer on the screen
-- vim.keymap.set('n', '<Leader>o', '<cmd>only<CR>')

-- New Tab
-- vim.keymap.set('n', '<C-T>', '<cmd>tabnew<CR>')

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
-- function _G.ReloadConfig()
--   -- clear any loaded packages, so submodules refresh with config refresh.
--   for name, _ in pairs(package.loaded) do
--     if name:match '^config' then
--       package.loaded[name] = nil
--     end
--   end

--   -- stop all clients.
--   vim.notify 'Stopping All Lsp Clients...'
--   vim.lsp.stop_client(vim.lsp.get_active_clients(), false)

--   vim.notify 'Sourcing $NEOHOME/init.lua...'
--   dofile(vim.env.MYVIMRC)
--   vim.notify 'Nvim configuration reloaded!'
-- end

-- vim.keymap.set('n', '<Leader><Leader>r', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
-- vim.keymap.set('n', '<Leader><Leader>s', '<Cmd>PackerSync<CR>', { noremap = true })

-- Switch buffers with tab
-- (experimental, not sure how this plays with everything else and TAB)
-- vim.keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>")
-- vim.keymap.set("n", "<TAB>", "<CMD>bnext<CR>")

-- save in insert mode
vim.keymap.set('i', '<C-s>', '<CMD>:w<CR><esc>')
vim.keymap.set('n', '<C-s>', '<CMD>:w<CR><esc>')



-- local leader = {
--   ["w"] = {
--     name = "+windows",
--     ["w"] = { "<C-W>p", "other-window" },
--     ["d"] = { "<C-W>c", "delete-window" },
--     ["-"] = { "<C-W>s", "split-window-below" },
--     ["|"] = { "<C-W>v", "split-window-right" },
--     ["2"] = { "<C-W>v", "layout-double-columns" },
--     ["h"] = { "<C-W>h", "window-left" },
--     ["j"] = { "<C-W>j", "window-below" },
--     ["l"] = { "<C-W>l", "window-right" },
--     ["k"] = { "<C-W>k", "window-up" },
--     ["H"] = { "<C-W>5<", "expand-window-left" },
--     ["J"] = { ":resize +5", "expand-window-below" },
--     ["L"] = { "<C-W>5>", "expand-window-right" },
--     ["K"] = { ":resize -5", "expand-window-up" },
--     ["="] = { "<C-W>=", "balance-window" },
--     ["s"] = { "<C-W>s", "split-window-below" },
--     ["v"] = { "<C-W>v", "split-window-right" },
--   },
--   c = {
--     name = "+code",
--   },
--   b = {
--     name = "+buffer",
--     ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
--     ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
--     ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
--     ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
--     ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
--     -- ["D"] = { "<cmd>:bd<CR>", "Delete Buffer & Window" },
--   },
--   g = {
--     name = "+git",
--     l = {
--       function()
--         require("utils").lazygit()
--       end,
--       "LazyGit",
--     },
--     L = {
--       function()
--         require("utils").lazygit(require("utils").get_root())
--       end,
--       "LazyGit",
--     },
--     c = { "<Cmd>Telescope git_commits<CR>", "commits" },
--     b = { "<Cmd>Telescope git_branches<CR>", "branches" },
--     s = { "<Cmd>Telescope git_status<CR>", "status" },
--     d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
--     h = { name = "+hunk" },
--   },
--   ["h"] = {
--     name = "+help",
--     t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
--     c = { "<cmd>:Telescope commands<cr>", "Commands" },
--     h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
--     m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
--     k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
--     s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
--     l = { vim.show_pos, "Highlight Groups at cursor" },
--     f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
--     o = { "<cmd>:Telescope vim_options<cr>", "Options" },
--     a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
--     p = {
--       name = "+packer",
--       p = { "<cmd>PackerSync<cr>", "Sync" },
--       s = { "<cmd>PackerStatus<cr>", "Status" },
--       i = { "<cmd>PackerInstall<cr>", "Install" },
--       c = { "<cmd>PackerCompile<cr>", "Compile" },
--     },
--   },
--   s = {
--     name = "+search",
--     g = { "<cmd>Telescope live_grep<cr>", "Grep" },
--     b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
--     s = {
--       function()
--         require("telescope.builtin").lsp_document_symbols({
--           symbols = {
--             "Class",
--             "Function",
--             "Method",
--             "Constructor",
--             "Interface",
--             "Module",
--             "Struct",
--             "Trait",
--             "Field",
--             "Property",
--           },
--         })
--       end,
--       "Goto Symbol",
--     },
--     h = { "<cmd>command_history<cr>", "Command History" },
--     m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
--     r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
--   },
--   f = {
--     name = "+file",
--     f = { "<cmd>Telescope find_files<cr>", "Find File" },
--     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--     n = { "<cmd>enew<cr>", "New File" },
--     z = "Zoxide",
--     d = "Dot Files",
--   },
--   o = {
--     name = "+open",
--     g = { "<cmd>Glow<cr>", "Markdown Glow" },
--   },
--   p = {
--     name = "+project",
--     p = "Open Project",
--     b = { ":Telescope file_browser cwd=~/projects<CR>", "Browse ~/projects" },
--   },
--   t = {
--     name = "toggle",
--     f = {
--       require("config.plugins.lsp.formatting").toggle,
--       "Format on Save",
--     },
--     s = {
--       function()
--         utils.toggle("spell")
--       end,
--       "Spelling",
--     },
--     w = {
--       function()
--         utils.toggle("wrap")
--       end,
--       "Word Wrap",
--     },
--     n = {
--       function()
--         utils.toggle("relativenumber", true)
--         utils.toggle("number")
--       end,
--       "Line Numbers",
--     },
--   },
--   ["<tab>"] = {
--     name = "tabs",
--     ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },
--     n = { "<cmd>tabnext<CR>", "Next" },
--     d = { "<cmd>tabclose<CR>", "Close" },
--     p = { "<cmd>tabprevious<CR>", "Previous" },
--     ["]"] = { "<cmd>tabnext<CR>", "Next" },
--     ["["] = { "<cmd>tabprevious<CR>", "Previous" },
--     f = { "<cmd>tabfirst<CR>", "First" },
--     l = { "<cmd>tablast<CR>", "Last" },
--   },
--   ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
--   [" "] = "Find File",
--   [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
--   ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
--   [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
--   ["C"] = {
--     function()
--       utils.clipman()
--     end,
--     "Paste from Clipman",
--   },
--   q = {
--     name = "+quit/session",
--     q = { "<cmd>qa<cr>", "Quit" },
--     ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
--     s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
--     l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
--     d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
--   },
--   x = {
--     name = "+errors",
--     x = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble" },
--     t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
--     tt = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo Trouble" },
--     T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
--     l = { "<cmd>lopen<cr>", "Open Location List" },
--     q = { "<cmd>copen<cr>", "Open Quickfix List" },
--   },
--   z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
--   T = {
--     function()
--       utils.test(true)
--     end,
--     "Plenary Test File",
--   },
--   D = {
--     function()
--       utils.test()
--     end,
--     "Plenary Test Directory",
--   },
-- }

-- for i = 0, 10 do
--   leader[tostring(i)] = "which_key_ignore"
-- end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto" } })
