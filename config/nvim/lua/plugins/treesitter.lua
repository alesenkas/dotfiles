return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install {
                    'vimdoc', 'vim', 'query', 'java', 'kotlin', 'lua', 'rust', 'javascript', 'typescript', 'html', 'css',
                    'json', 'yaml'
            }
        end
    }
}
