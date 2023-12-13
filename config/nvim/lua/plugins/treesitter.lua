return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects' }
        },
        config = function () 
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = { 
                    'java', 'kotlin', 'lua', 'rust', 'javascript', 'typescript', 'html', 'json', 'yaml', 'vim' 
                },
                higlight = {
                    enabled = true,
                    disable = {},
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner', 
                        }
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>L'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>H'] = '@parameter.inner',
                        }
                    },
                    move = {
                        enable = true,
                        goto_next_start = {
                            [']]'] = '@function.outer',
                        },
                        goto_previous_start = {
                            ['[['] = '@function.outer',
                        },
                    },
                }
            })
        end
    }
}
