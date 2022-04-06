-- Sets up LSP Config Plugin
local common = require("common")
local lspformat = require("lsp-format")

lspformat.setup {}

local function diagnostic_config()
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "single",
	})
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
	})
end

local function define_signs()
	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
end

local M = {}

M.on_attach = function(client)
	diagnostic_config()
	define_signs()
  lspformat.on_attach(client)

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	common.buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	common.buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	common.buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	common.buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	common.buf_set_keymap("n", "ga", "<cmd>Telescope lsp_code_actions<CR>", opts)
	common.buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	common.buf_set_keymap("n", "gl", "<cmd>Telescope lsp_document_diagnostics<CR>", opts)
	common.buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	common.buf_set_keymap("n", "gs", "<cmd>Telescope lsp_document_symbols<CR>", opts)
	common.buf_set_keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
	common.buf_set_keymap("n", "gw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
end

vim.cmd("set completeopt=menu,preview,noselect")

-- Setup lspconfig.
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--capabilities = capabilities
--}

--M.disable_formatting = function(client)
	--client.resolved_capabilities.document_formatting = false
	--client.resolved_capabilities.document_range_formatting = false
--end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- use this when you don't want autoformatting
--M.no_formatting_config = {
	--on_attach = function(client)
		--M.on_attach()
		--M.disable_formatting(client)
	--end,
	--capabilities = M.capabilities,
--}

M.default_config = {
	on_attach = M.on_attach,
	capabilities = M.capabilities,
}

return M
