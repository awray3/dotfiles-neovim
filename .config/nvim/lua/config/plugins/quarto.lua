--[[
  ___                   _        
 / _ \ _   _  __ _ _ __| |_ ___  
| | | | | | |/ _` | '__| __/ _ \ 
| |_| | |_| | (_| | |  | || (_) |
 \__\_\\__,_|\__,_|_|   \__\___/ 
 
 Github: https://github.com/quarto-dev/quarto-nvim
]]
--
return {
    'quarto-dev/quarto-nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    ft = { 'quarto' },
    config = {
        debug = false,
        lspFeatures = {
            enabled = true,
            languages = { 'r', 'python', 'julia' },
            diagnostics = {
                enabled = true,
                triggers = { 'BufEnter', 'InsertLeave', 'TextChanged' },
            },
            cmpSource = {
                enabled = true,
            },
        },
    }
}