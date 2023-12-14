return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap
                -- TODO keymaps


                -- formatting
                if client.server_capabilities.documentFormattingProvider then
                    keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
                    -- autofortmat on save
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format { async = false } end
                    })
                end
                -- formatting selection
                if client.server_capabilities.documentRangeFormattingProvider then
                    keymap.set('v', '<leader>f', vim.lsp.buf.format, opts)
                end
            end

            local lspconfig = require 'lspconfig'
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

            lspconfig['lua_ls'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    }
                }
            })
        end
    }
}
