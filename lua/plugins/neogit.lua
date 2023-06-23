local M = {
    "TimUntersberger/neogit",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    require("neogit").setup({
    })
end

return M
