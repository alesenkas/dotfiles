return {
    'mg979/vim-visual-multi',
    config = function()
        vim.keymap.set("n", "<A-j>", "<Plug>(VM-Find-Under)");
        vim.keymap.set("v", "<A-j>", "<Plug>(VM-Find-Subword-Under)");
    end
}
