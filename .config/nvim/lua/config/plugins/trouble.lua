return {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = {
        auto_open = false,
        use_diagnostic_signs = true,
    },
}