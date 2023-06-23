local M = {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    require("diffview").setup({
    })
end

return M
