local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}

function M.config()
    require("which-key").setup({
        window = {
            border = "none",          -- none, single, double, shadow
            position = "bottom",      -- bottom, top
            margin = { 0, 0, 0, 0 },  -- extra window margin [top, right, bottom, left]
            padding = { 2, 1, 2, 1 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3,                    -- spacing between columns
            align = "center",               -- align columns left, center or right
        },
        show_help = false,                  -- show a help message in the command line for using WhichKey
        show_keys = false,                  -- show the currently pressed key and its label as a message in the command line
        plugins = {
            presets = {
                windows = false,
            },
        }
    })
end

return M
