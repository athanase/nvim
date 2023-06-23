local M = {
    "phaazon/hop.nvim",
    event = "VeryLazy",
}

function M.config()
    require("hop").setup({})
end

return M
