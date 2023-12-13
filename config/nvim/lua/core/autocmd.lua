-- define autocommands with Lua APIs
-- See :help api-autocmd, :help augroup

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- remove whitespace on save
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})

-- higlight search
augroup("SearcHiglight", { clear = true })
autocmd("CmdlineEnter", {
    pattern = "/,\\?",
    command = ":set hlsearch"
})
autocmd("CmdlineLeave", {
    pattern = "/,\\?",
    command = ":set nohlsearch"
})
