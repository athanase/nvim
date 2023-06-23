local M = {
    "ten3roberts/qf.nvim",
    event = "VeryLazy",
}

function M.config()
    require("qf").setup({
        c = {
            auto_close = true,      -- Automatically close location/quickfix list if empty
            auto_follow = 'prev',   -- Follow current entry, possible values: prev,next,nearest, or false to disable
            auto_follow_limit = 8,  -- Do not follow if entry is further away than x lines
            follow_slow = true,     -- Only follow on CursorHold
            auto_open = true,       -- Automatically open list on QuickFixCmdPost
            auto_resize = true,     -- Auto resize and shrink location list if less than `max_height`
            max_height = 30,        -- Maximum height of location/quickfix list
            min_height = 20,        -- Minimum height of location/quickfix list
            wide = true,            -- Open list at the very bottom of the screen, stretching the whole width.
            number = false,         -- Show line numbers in list
            relativenumber = false, -- Show relative line numbers in list
            unfocus_close = false,  -- Close list when window loses focus
            focus_open = false,     -- Auto open list on window focus if it contains items
        },
        close_other = false,        -- Close location list when quickfix list opens
        pretty = false,             -- "Pretty print quickfix lists"
    })
end

return M
