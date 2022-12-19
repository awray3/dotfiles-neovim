--[[
--  Common LSP configuration goes here.
--]]
local M = {}

-- sets up the hover function so that empty lines don't spit "No information available
vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.contents) then
        return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
        return
    end
    return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end

local function define_signs()
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    define_signs()
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- workspace-related lsp
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')


    -- trouble keymaps
    nmap('<leader>tt', '<Cmd>TroubleToggle<CR>', '[T]oggle [T]rouble')
    nmap('<leader>tw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', 'Toggle [T]rouble [W]orkspace diagnostics')
    nmap('<leader>td', '<Cmd>TroubleToggle document_diagnostics<CR>', 'Toggle [T]rouble [D]ocument diagnostics')
    nmap('<leader>tl', '<Cmd>TroubleToggle loclist<CR>', 'Toggle [T]rouble [L]oclist')
    nmap('<leader>tf', '<Cmd>TroubleToggle quickfix<CR>', 'Toggle [T]rouble [Q]uickfix')

    vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = function()
            local opts_callback = {
                focusable = false,
                close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(opts_callback)
        end,
    })

    -- null-ls formatting autogroup. This comes from the null-ls wiki on Github.
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    if client.name == 'null-ls' then
        -- creates the :Format command. Not sure if this is better here or in Null-ls
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            if vim.lsp.buf.format then
                vim.lsp.buf.format()
            elseif vim.lsp.buf.formatting then
                vim.lsp.buf.formatting()
            end
        end, { desc = 'Format current buffer with Null-LS' })


        --
        -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
        -- if client.supports_method 'textDocument/formatting' then
        --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        --     vim.api.nvim_create_autocmd('BufWritePre', {
        --         group = augroup,
        --         buffer = bufnr,
        --         callback = function()
        --             vim.lsp.buf.format {
        --                 bufnr = bufnr,
        --             }
        --         end,
        --     })
        -- end
    end

    vim.notify('Loaded ' .. client.name .. ' language server!')
end

M.on_attach = on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
M.capabilities = capabilities

return M
