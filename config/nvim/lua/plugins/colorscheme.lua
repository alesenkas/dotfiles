return {
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        config = function()
            vim.opt.background = 'dark'
            vim.opt.termguicolors = true
            require("gruvbox").setup({
                italic = {
                    strings = false
                }
            })
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
}
