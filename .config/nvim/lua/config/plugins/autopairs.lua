--[[
             _                    _          
  __ _ _   _| |_ ___  _ __   __ _(_)_ __ ___ 
 / _` | | | | __/ _ \| '_ \ / _` | | '__/ __|
| (_| | |_| | || (_) | |_) | (_| | | |  \__ \
 \__,_|\__,_|\__\___/| .__/ \__,_|_|_|  |___/
                     |_|                      
Github: https://github.com/windwp/nvim-autopairs
]]

local M = {
  'windwp/nvim-autopairs',
  -- TODO: any good lazy settings?
}

function M.config()
  local autopairs = require("nvim-autopairs")
  local ap_cmp = require("nvim-autopairs.completion.cmp")

  autopairs.setup()
  autopairs.remove_rule '`'

  -- autopairs and nvim-cmp presumably
  ap_cmp.setup({
    map_cr = false, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false, -- use insert confirm behavior instead of replace
    map_char = { -- modifies the function or method delimiter by filetypes
      all = '(',
      tex = '{'
    }
  })


end

return M
