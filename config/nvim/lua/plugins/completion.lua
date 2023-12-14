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
            'onsails/lspkind.nvim', -- icons
        },
        opts = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'
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
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50,   -- will not show more than 50 characters
                        ellispsis_char = '...'
                    })
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
