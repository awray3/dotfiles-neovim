-- _____    _
--|_   _|__| | ___  ___  ___ ___  _ __   ___
--  | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
--  | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  |_|\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
--  The tool for searching things

local telescope = require("telescope")
local opts = { noremap = true, silent = true }

local telescope_bindings = {
    [""] = "builtin",
    f = "find_files",
    g = "live_grep",
    b = "buffers",
    h = "help_tags",
    j = "jump_list",
    s = "current_buffer_fuzzy_find",
    m = "man_pages",
    r = "lsp_references",
    d = "lsp_definitions",
    c = "colorscheme",
    k = "file_browser",
}

-- telescope search-under-word (replaces default # action)
vim.keymap.set("n", "#", "<Cmd>Telescope grep_string<CR>")

for postfix_key, cmd in pairs(telescope_bindings) do
    vim.keymap.set("n", "<leader>t" .. postfix_key, "<cmd>Telescope " .. cmd .. " <CR>", opts)
end

local open_dotfiles = function(cwd)
    return function()
        require("telescope.builtin").find_files({
            require("telescope.themes").get_ivy(),
            cwd = cwd,
        })
        -- something like vim.fn['cd'](cwd) maybe? but needs to be on the action?
    end
end

vim.keymap.set("n", "<leader>tn", open_dotfiles("$NEOHOME"), opts)
vim.keymap.set("n", "<leader>tz", open_dotfiles("$ZSH"), opts)

telescope.setup({
    defaults = {
        path_display = { shorten = 2 },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
