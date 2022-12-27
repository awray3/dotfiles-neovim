--[[
                            _              _           
 _ __   ___ _   _ _ __ __ _| |  _ ____   _(_)_ __ ___  
| '_ \ / _ \ | | | '__/ _` | | | '_ \ \ / / | '_ ` _ \ 
| | | |  __/ |_| | | | (_| | |_| | | \ V /| | | | | | |
|_| |_|\___|\__,_|_|  \__,_|_(_)_| |_|\_/ |_|_| |_| |_| 

Github: https://github.com/dense-analysis/neura
]]
local M = {
    'dense-analysis/neural',
    dependencies = {
        { 'MunifTanjim/nui.nvim' },
        { 'ElPiloto/significant.nvim' },
    },
    cmd = {
        'NeuralCode',
        'NeuralText',
    },
}

-- M.keys = {
--     '<leader><leader>ad',
--     '<Cmd>NeuralCode add documentation<CR>',
--     mode = 'v',
--     desc = '[A]dd [d]ocumentation for selection (EXPERIMENTAL)',
-- }
M.keys = {
    ["<leader><leader>"] = {
        ad = {
            "<cmd>NeuralCode add documentation<cr>",
            '[A]dd [d]ocumentation for selection (EXPERIMENTAL)',
        }
    },
    mode = 'v',
}

local read_api_key = function()

    local cred_file = vim.fn.expand '~/.openai/credentials'
    local fp = assert(io.open(cred_file, 'r'), 'Credentials not found')
    --- shhh it's a secret.
    local api_key = fp:read '*l'
    fp:close()

    return api_key
end

M.config = {
    open_ai = {
        read_api_key()
    }
}

return M