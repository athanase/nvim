-- Adjust the path to your executable
local codelldb = require("utils.codelldb")

local dap = require("dap")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "/opt/llvm-16/bin/lldb",
        args = { "--port", "${port}" },

        -- detached = false,
    }
}
