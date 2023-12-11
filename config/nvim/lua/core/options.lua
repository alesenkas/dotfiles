local opt = vim.opt

-- show window title
opt.title = true

-- automatically write file if changed
opt.autowrite = true

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs, text identation
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for ident width
opt.expandtab = true -- expand tab to spaces
opt.softtabstop = 4 -- remove tab as 4 spaces
opt.autoindent = true -- copy ident
opt.wrap = false -- disable line wrapping

-- backpace
opt.backspace = "indent,eol,start"

-- highlight cursor line
opt.cursorline = true

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default

-- search settings
opt.hlsearch = false -- no higlighting search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- asumes case sensetive search when using mixed case

-- suppot russian keymap
opt.keymap = "russian-jcukenwin"
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- undo files
local undo_dir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, 0700)
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true
