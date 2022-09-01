local lsp_installer = require("nvim-lsp-installer")
local common = require("lsp/common")

-- Provide settings first!
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = common.default_config

	if server.name == "sumneko_lua" then
		-- only apply these settings for the "sumneko_lua" server
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the 'vim'
					globals = { "vim", "bufnr" },
				},
			},
		}
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
	server:setup(opts)
end)
