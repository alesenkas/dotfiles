return {
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-emoji',
            'saadparwaiz1/cmp_luasnip',
        },
        opts = function()
            local cmp = require 'cmp'
            return {
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<c-j>'] = cmp.mapping.select_next_item(),
                    ['<c-k>'] = cmp.mapping.select_prev_item(),
                    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-f>'] = cmp.mapping.scroll_docs(4),
                    ['<c-space>'] = cmp.mapping.complete(),
                    ['<cr>'] = cmp.mapping.confirm { select = true },
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                }),
            }
        end
    }
}
