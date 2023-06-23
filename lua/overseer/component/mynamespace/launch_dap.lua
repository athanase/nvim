local util = require("overseer.util")
local constants = require("overseer.constants")
local STATUS = constants.STATUS

return {
    params = {
        build_directory = {
            type = "string"
        },
        target = {
            type = "string"
        }
    },
    constructor = function(params)
        return {
            on_complete = function(self, task, status, result)
                if status == STATUS.SUCCESS then
                    local dap = require('dap')
                    dap.run({
                        type = "cpp",
                        request = 'launch',
                        program = params.build_directory .. "/output/" .. params.target,
                        args = {},
                        cwd = params.build_directory .. "/output",
                        stopOnEntry = false,
                        runInTerminal = false,
                        console = "integratedTerminal",
                    })
                end
            end
        }
    end,
}
