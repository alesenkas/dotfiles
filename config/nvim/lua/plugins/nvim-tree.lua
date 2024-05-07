return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local nvimtree = require 'nvim-tree'

            -- recommended setting from nvim-tree documentation
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            nvimtree.setup({
                diagnostics = {
                    enable = true
                },
                filters = {
                    dotfiles = false
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500
                },
                view = {
                    width = 30,
                    side = 'left',
                    preserve_window_proportions = false,
                    number = false,
                    relativenumber = false,
                    signcolumn = 'yes'
                }
            })

            vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeFindFileToggle<CR>")
        end
    }
}
