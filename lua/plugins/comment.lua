local M = {
    "numToStr/Comment.nvim",
    keys = {
        {
            "<C-_>",
            mode = "n",
            "<Plug>(comment_toggle_linewise_current)",
        },
        {
            "<C-_>",
            mode = "x",
            "<Plug>(comment_toggle_linewise_visual)",
        },
        {
            "<C-M-_>",
            mode = "n", "<Plug>(comment_toggle_blockwise_current)",
        },
        {
            "<C-M-_>",
            mode = "x",
            "<Plug>(comment_toggle_blockwise_visual)",
        },
        {
            "<C-/>",
            mode = "n",
            "<Plug>(comment_toggle_linewise_current)",
        },
        {
            "<C-/>",
            mode = "x",
            "<Plug>(comment_toggle_linewise_visual)",
        },
        {
            "<C-A-/>",
            mode = "n",
            "<Plug>(comment_toggle_blockwise_current)",
        },
        {
            "<C-A-/>",
            mode = "x",
            "<Plug>(comment_toggle_blockwise_visual)",
        },
    },
}

function M.config()
    local comment = require("Comment")
    comment.setup({
        extra = {
            ---Add comment on the line above
            above = "gcO",
            ---Add comment on the line below
            below = "gco",
            ---Add comment at the end of line
            eol = "gcA",
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            ---Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
        },
    })
end

return M
