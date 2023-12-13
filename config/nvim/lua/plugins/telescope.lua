return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            {
                'nvim-telescope/telescope-fzy-native.nvim',
                config = function() require 'telescope'.load_extension 'fzy_native' end,
            }
        },
        keys = {
            {'<leader>n', function() require 'telescope.builtin'.find_files() end },
            {'<leader>e', function() require 'telescope.builtin'.buffers() end },
            -- live grep required installed ripgrep
            {'<leader>lg', function() require 'telescope.builtin'.live_grep() end },
        },
        opts = {
            pickers = {
                find_files = {
                    hidden = true
                },
            },
        },
    }
}
