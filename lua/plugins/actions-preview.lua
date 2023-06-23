local M = {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
}


function M.config()
    require("actions-preview").setup({
        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
        diff = {
            ctxlen = 3,
        },
        -- priority list of preferred backend
        backend = { "telescope", "nui" },
        -- options for telescope.nvim: https://github.com/nvim-telescope/telescope.nvim#themes
        telescope = require("telescope.themes").get_cursor({
            layout_config = { width = 0.80, height = 0.40 },
            -- prompt = " ",
            -- results_height = 15,
            previewer = true,
        }),
        -- options for nui.nvim components
        nui = {
            -- component direction. "col" or "row"
            dir = "col",
            -- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
            keymap = nil,
            -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
            layout = {
                position = "50%",
                size = {
                    width = "60%",
                    height = "60%",
                },
                min_width = 40,
                min_height = 10,
                relative = "editor",
            },
            -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
            preview = {
                size = "60%",
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
            -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
            select = {
                size = "40%",
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
        },
    })
end

return M
