return {
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
            })
        end,
        keys = {
            -- map <leader>sr to open grug-far in normal and visual modes
            {
                '<leader>sr',
                function() require('grug-far').open() end,
                mode = { 'n', 'v' },
                desc = 'Grug-far: Open search'
            },
            -- map <leader>sR to open grud-far in normal and visial modes for search/replace to current file
            {
                '<leader>sR',
                function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,
                mode = { 'n', 'v' },
                desc = 'Grug-far: Open search in current file'
            }
        }
    }
}
