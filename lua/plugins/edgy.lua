local M = {
    "folke/edgy.nvim",
    event = "VeryLazy",
    enabled = true,
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
}

function M.config()
    require("edgy").setup({
        animate = {
            enabled = false,
        },
        wo = {
            -- Setting to `true`, will add an edgy winbar.
            -- Setting to `false`, won't set any winbar.
            -- Setting to a string, will set the winbar to that string.
            winbar = false,
            winfixwidth = true,
            winfixheight = false,
            winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
            spell = false,
            signcolumn = "no",
        },
        bottom = {
            -- {
            --     ft = "toggleterm",
            --     size = { height = 0.4 },
            --     -- exclude floating windows
            --     filter = function(buf, win)
            --         return vim.api.nvim_win_get_config(win).relative == ""
            --     end,
            --
            -- },
            { ft = "OverseerList", title = "OverseerList", size = { height = 13 } },
            { ft = "qf",           title = "QuickFix",     size = { height = 40 } },
            {
                ft = "help",
                size = { height = 40 },
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            { ft = "spectre_panel", size = { height = 0.4 } },

        },
        -- enable this on Neovim <= 0.10.0 to properly fold edgebar windows.
        -- Not needed on a nightly build >= June 5, 2023.
        fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
    })
end

return M
