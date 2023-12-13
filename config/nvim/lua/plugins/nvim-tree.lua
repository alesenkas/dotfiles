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
                view = {
                    width = 30,
                    relativenumber = true
                }
            })

            vim.keymap.set("n", "<F12>", "<cmd>NvimTreeFindFileToggle<CR>")
        end
    }
}
