local M = {
    "athanase/solarized.nvim",
    lazy = false,
    dev = true,
    priority = 1000,
}

function M.config()
    require("solarized").set()
end

return M
