local M = {
    "akinsho/toggleterm.nvim",
    enabled = true,
    lazy = false,
}

function M.config()
    require("toggleterm").setup({
        size = 25,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "tab",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
        auto_scroll = true,
        -- on_create = function()
        --     pcall(function() vim.cmd ':ToggleTermSetName test<cr>' end)
        -- end
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })
    function _lazygit_toggle()
        lazygit:toggle()
    end

    local bottom = Terminal:new({ cmd = "btm", hidden = true, direction = "tab" })
    function _bottom_toggle()
        bottom:toggle()
    end
end

return M
