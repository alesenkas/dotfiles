return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install {
                    'java', 'kotlin', 'lua', 'rust', 'javascript', 'typescript', 'html', 'css',
                    'json', 'yaml', 'vim'
            }
        end
    }
}
