return {
    {
        "dinhhuy258/git.nvim",
        event = "BufReadPre",
        opts = {
            keymaps = {
                -- open blame window
                blame = "<Leader>ga",
                -- open file/folder in git repository
                browse = "<Leader>go",
            },
        },
    }
}
