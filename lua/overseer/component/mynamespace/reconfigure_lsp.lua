local Notifier = require("overseer.notifier")
local util = require("overseer.util")
local constants = require("overseer.constants")
local STATUS = constants.STATUS

return {
    desc = "Include a description of your component",
    params = {
        build_directory = {
            type = "string"
        },
        system = {
            desc = "When to send a system notification",
            type = "enum",
            choices = { "always", "never", "unfocused" },
            default = "never",
        },
    },
    constructor = function(params)
        return {
            notifier = Notifier.new({ system = params.system }),
            on_init = function(self, task)
                local status = os.execute("mkdir -p " .. params.build_directory)
            end,
            on_complete = function(self, task, status, result)
                if status == STATUS.SUCCESS then
                    local root_dir = vim.fn.getcwd()
                    local rm_status = os.execute("rm " .. root_dir .. "/compile_commands.json")
                    local src_file = params.build_directory .. "/compile_commands.json"
                    local link_status = os.execute("ln -s " .. src_file .. " " .. root_dir)
                    pcall(vim.cmd, "LspRestart")
                    local message = string.format("LSP reconfigured for: %s", params.build_directory)
                    local level = util.status_to_log_level(status)
                    self.notifier:notify(message, level)
                end
            end
        }
    end,
}
