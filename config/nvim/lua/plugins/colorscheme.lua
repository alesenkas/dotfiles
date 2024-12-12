return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = 'dark'
            vim.opt.termguicolors = true
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_enable_italic = false
            vim.cmd.colorscheme "gruvbox-material"
        end,
    },
}
