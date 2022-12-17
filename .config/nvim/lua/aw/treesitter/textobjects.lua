local select = {
    enable = true,
    lookahead = true,
    keymaps = {
        ['af'] = { query = '@function.outer', desc = 'Select around a function' },
        ['if'] = { query = '@function.inner', desc = 'Select function body' },
        ['ac'] = { query = '@class.outer', desc = 'Select around class definition' },
        ['ic'] = { query = '@class.inner', desc = 'Select inside class definition' },
        ['ia'] = { query = '@parameter.inner', desc = 'Select parameter' },
        ['aa'] = { query = '@parameter.outer', desc = 'Select around parameter' },
    },

    selection_modes = {
        ['@parameter.inner'] = 'v',
        ['@parameter.outer'] = 'v',
    },
}

return {
    select = select,
}
