local M = {
  'glepnir/lspsaga.nvim',
  -- TODO: what are good settings for this?
}

function M.config()
  local saga = require("lspsaga")
  local signs = require("utils").signs
  saga.init_lsp_saga({
    border_style = 'rounded',
    code_action_icon = signs.LightBulb,
    symbol_in_winbar = {
      in_custom = true
    }
  })
end

return M