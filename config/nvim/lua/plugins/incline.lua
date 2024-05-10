return {
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        priority = 1200,
        config = function()
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = {
                    cursorline = true
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    local status = { "" }
                    if (vim.bo[props.buf].modified) then
                        status = { " ", guifg = "#d79921" }
                    end
                    return { status, { icon, guifg = color }, { " " }, { filename } }
                end
            })
        end
    }
}
