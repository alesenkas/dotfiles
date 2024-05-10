return {
    {
        "dinhhuy258/git.nvim",
        event = "BufReadPre",
        opts = {
            keymaps = {
                -- open blame window
                blame = "<Leader>gb",
                -- open file/folder in git repository
                browse = "<Leader>go",
            },
        },
    }
}
