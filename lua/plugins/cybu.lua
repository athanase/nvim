local M = {
    "ghillb/cybu.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
}

function M.config()
    require("cybu").setup({
        position = {
            relative_to = "win",  -- win, editor, cursor
            anchor = "topcenter", -- topleft, topcenter, topright,
            -- centerleft, center, centerright,
            -- bottomleft, bottomcenter, bottomright
            vertical_offset = 10,  -- vertical offset from anchor in lines
            horizontal_offset = 0, -- vertical offset from anchor in columns
            max_win_height = 8,    -- height of cybu window in lines
            max_win_width = 0.6,   -- integer for absolute in columns
            -- float for relative to win/editor width
        },
        style = {
            path = "tail",              -- absolute, relative, tail (filename only)
            path_abbreviation = "none", -- none, shortened
            border = "rounded",         -- single, double, rounded, none
            separator = " ",            -- string used as separator
            prefix = "…",             -- string used as prefix for truncated paths
            padding = 1,                -- left & right padding in number of spaces
            hide_buffer_id = true,      -- hide buffer IDs in window
            devicons = {
                enabled = true,         -- enable or disable web dev icons
                colored = true,         -- enable color for web dev icons
                truncate = true,        -- truncate wide icons to one char width
            },
            highlights = {
                current_buffer = "CybuFocus",      -- current / selected buffer
                adjacent_buffers = "CybuAdjacent", -- buffers not in focus
                background = "CybuBackground",     -- window background
                border = "CybuBorder",             -- border of the window
            },
        },
        behavior = {
            -- set behavior for different modes
            mode = {
                default = {
                    switch = "immediate", -- immediate, on_close
                    view = "paging",      -- paging, rolling
                },
                last_used = {
                    switch = "immediate", -- immediate, on_close
                    view = "paging",      -- paging, rolling
                },
                auto = {
                    view = "paging", -- paging, rolling
                },
            },
            show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
        },
        display_time = 500,          -- time the cybu window is displayed
        exclude = {                  -- filetypes, cybu will not be active
            "neo-tree",
            "nvim-tree",
            "fugitive",
            "qf",
            "overseer",
            "toggleterm",
        },
        fallback = function()
        end, -- arbitrary fallback function used in excluded filetypes
    })
end

return M
