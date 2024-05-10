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
                    adaptive_size = true,
                    width = 40,
                    side = 'left',
                    number = false,
                    relativenumber = false,
                    signcolumn = 'yes'
                }
            })

            vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeFindFileToggle<CR>")     -- neovide
            vim.keymap.set("n", "<leader>1", "<cmd>NvimTreeFindFileToggle<CR>") -- terminal
        end
    }
}
