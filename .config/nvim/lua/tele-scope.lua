local tele = require("telescope")

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "gb", "<cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>Telescope marks<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>Telescope file_browser<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>Telescope man_pages<CR>", opts)
vim.api.nvim_set_keymap(
	"n",
	"<C-P>",
	"<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full'}<CR>",
	opts
)

tele.setup({})

-- tele.load_extension("fzf")
tele.load_extension("heading")
tele.load_extension("project")
