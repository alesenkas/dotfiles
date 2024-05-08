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
    group   = "SearcHiglight",
    pattern = "/,\\?",
    command = ":set hlsearch"
})
autocmd("CmdlineLeave", {
    group = "SearcHiglight",
    pattern = "/,\\?",
    command = ":set nohlsearch"
})

-- detect not typical file types
augroup("DetectFileTypes", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
    group = "DetectFileTypes",
    pattern = "*.es6",
    command = ":setfiletype javascript"
})
