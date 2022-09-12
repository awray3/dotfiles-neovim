-- === TAB/Space settings === "
-- Insert spaces when TAB is pressed.
vim.bo.textwidth = 120
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.autoindent = true

require("aw.completion").setup_buffer_completion()
