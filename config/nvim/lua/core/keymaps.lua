-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- move lines with Ctrl + (Shift) + J/K
keymap.set("n", "<C-j>", ":m +1<CR>", { noremap = true, silent = true })
keymap.set("i", "<C-j>", "<Esc>:m +1<CR>gi", { noremap = true, silent = true })
keymap.set("v", "<C-j>", ":m '>+1<CR>gvgv", { noremap = true, silent = true })
keymap.set("i", "<C-k>", "<Esc>:m -2<CR>gi", { noremap = true, silent = true })
keymap.set("v", "<C-k>", ":m '<-2<CR>gvgv", { noremap = true, silent = true })
keymap.set("n", "<C-k>", ":m -2<CR>", { noremap = true, silent = true })

-- file operations
keymap.set("n" , "<C-s>", ":w<CR>") -- save
keymap.set("n", "<C-q>", ":q<CR>") -- quit

-- system clipboard (required installed xclip)
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>y", '"+yy')
keymap.set("v", "<leader>d", '"+d')
keymap.set("n", "<leader>p", '"+p')
keymap.set("n", "<leader>P", '"+P')
keymap.set("v", "<leader>p", '"+p')
keymap.set("v", "<leader>P", '"+P')

