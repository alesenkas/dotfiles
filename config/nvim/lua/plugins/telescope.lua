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
            { '<leader>n',  function() require 'telescope.builtin'.find_files() end },
            { '<leader>e',  function() require 'telescope.builtin'.buffers() end },
            -- live grep required installed ripgrep
            { '<leader>lg', function() require 'telescope.builtin'.live_grep() end },
            { '<A-`>',      function() require 'telescope.builtin'.commands() end },
            -- git
            { '<leader>gf', function() require 'telescope.builtin'.git_files() end },
            { '<leader>gc', function() require 'telescope.builtin'.git_commits() end },
            { '<leader>gb', function() require 'telescope.builtin'.git_branches() end },
            { '<leader>gs', function() require 'telescope.builtin'.git_status() end },
        },
        opts = {
            defaults = {
                layout_strategy = 'vertical',
                mappings = {
                    i = {
                        ['<C-j>'] = require 'telescope.actions'.move_selection_next,
                        ['<C-k>'] = require 'telescope.actions'.move_selection_previous,
                    }
                },
                file_ignore_patterns = {
                    "^.*%.git.*$"
                },
            },
            pickers = {
                find_files = {
                    hidden = true
                },
            },
        },
    }
}
