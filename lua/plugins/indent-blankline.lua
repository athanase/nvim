local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
}

function M.config()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,
        use_treesitter = false,
        char = "▏",
        --context_char = "▎",
        show_trailing_blankline_indent = false,
        filetype_exclude = {
            "coc-explorer",
            "dashboard",
            "floaterm",
            "alpha",
            "help",
            "packer",
            "NvimTree",
        },
    })
end

return M
