return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            ["javascript"] = { "prettier" },
            ["javascriptreact"] = { "prettier" },
            ["typescript"] = { "prettier" },
            ["typescriptreact"] = { "prettier" },
            ["vue"] = { "prettier" },
            ["css"] = { "prettier" },
            ["scss"] = { "prettier" },
            ["less"] = { "prettier" },
            ["html"] = { "prettier" },
            ["json"] = { "prettier" },
            ["jsonc"] = { "prettier" },
            ["yaml"] = { "yamlfix" },
            ["markdown"] = { "prettier" },
            ["markdown.mdx"] = { "prettier" },
            ["graphql"] = { "prettier" },
        },
        formatters = {
            prettier = {
                prepend_args = { "--tab-width", "4", "--print-width", "110", "--trailing-comma", "none" },
            }
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true }
    }

}
