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
                keymap.set('n', 'gd', vim.lsp.buf.type_definition, opts)
                keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                keymap.set('n', '<leader>q', vim.lsp.buf.hover, opts)
                keymap.set('n', '<c-p>', vim.lsp.buf.signature_help, opts)
                keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

                -- in dropdown
                local tel_builtin = require 'telescope.builtin'
                local tel_themes = require 'telescope.themes'
                keymap.set('n', 'gr', function() tel_builtin.lsp_references(tel_themes.get_dropdown {}) end, opts)
                keymap.set('n', 'gS', function() tel_builtin.lsp_workspace_symbols(tel_themes.get_dropdown {}) end, opts)
                keymap.set('n', 'gs', function() tel_builtin.lsp_document_symbols(tel_themes.get_dropdown {}) end, opts)

                -- diagnostic
                keymap.set('n', '<F2>', vim.diagnostic.goto_next, opts)
                keymap.set('n', '<S-F2>', vim.diagnostic.goto_prev, opts)

                -- formatting
                if client.server_capabilities.documentFormattingProvider then
                    keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
                    -- autoformat on save
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

            local def_config_servers = {
                'rust_analyzer',
                'tsserver',
                'cssls',
                'stylelint_lsp',
                'html'
            }
            for _, server_name in ipairs(def_config_servers) do
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach
                })
            end

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
