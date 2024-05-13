return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'dinhhuy258/git.nvim' },
            { 'octarect/telescope-menu.nvim' },
        },
        keys = {
            { '<leader>n',  function() require 'telescope.builtin'.find_files() end },
            { '<leader>e',  function() require 'telescope.builtin'.buffers() end },
            -- live grep required installed ripgrep
            { '<leader>lg', function() require 'telescope.builtin'.live_grep() end },
            { '<A-`>',      function() require 'telescope.builtin'.commands() end },
            -- git
            { '<leader>gf', function() require 'telescope.builtin'.git_files() end },
            { '<leader>gm', function() require 'telescope'.extensions.menu.git {} end }
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
            extensions = {
                ['ui-select'] = {
                    require 'telescope.themes'.get_dropdown {}
                },
                menu = {
                    git = {
                        items = {
                            { "Status",      function() require 'telescope.builtin'.git_status() end },
                            { "Blame",       function() require 'git.blame'.blame() end },
                            { "Revert file", function() require 'git.revert'.open(true) end },
                            { "Diff",        function() require 'git.diff'.open() end },
                            { "Commits",     function() require 'telescope.builtin'.git_commits() end },
                            { "Branches",    function() require 'telescope.builtin'.git_branches() end }
                        }
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = true
                },
            },
        },
        config = function(_, opts)
            local telescope = require 'telescope'
            telescope.setup(opts)
            telescope.load_extension 'fzy_native'
            telescope.load_extension 'ui-select'
            telescope.load_extension 'menu'
        end
    }
}
