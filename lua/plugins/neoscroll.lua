local M = {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
}

function M.config()
    require("neoscroll").setup({
    })

    local t    = {}
    t['<S-l>'] = { 'scroll', { '-0.10', 'false', '25' } }
    t['<S-k>'] = { 'scroll', { '0.10', 'false', '25' } }
    --
    require('neoscroll.config').set_mappings(t)
end

return M
