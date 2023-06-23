local M = {
    "lewis6991/impatient.nvim",
}

function M.config()
    local impatient = require("impatient")
    impatient.enable_profile()
end

return M
