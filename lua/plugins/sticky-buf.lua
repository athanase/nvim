local M = {
    "stevearc/stickybuf.nvim",
    event = "VeryLazy",
    enabled = false
}

function M.config()
    require("stickybuf").setup({})
end

return M
