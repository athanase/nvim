local M = {
    "stevearc/oil.nvim",
    event = "VeryLazy",
}

function M.config()
    require("oil").setup({
        use_default_keymaps = false,
        keymaps = {
            -- ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            -- ["<C-s>"] = "actions.select_vsplit",
            -- ["<C-h>"] = "actions.select_split",
            -- ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-q>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            -- ["-"] = "actions.parent",
            -- ["_"] = "actions.open_cwd",
            -- ["`"] = "actions.cd",
            -- ["~"] = "actions.tcd",
            -- ["g."] = "actions.toggle_hidden",
        },
    })
end

return M
