-- local constants = require("overseer.constants")

return {
    name = 'Build and run target',
    priority = 1,
    params = {
        compiler = {
            type = "enum",
            name = "Compiler",
            order = 4,
            optional = false,
            default = "gcc",
            choices = { "gcc", "clang" }
        },
        build_type = {
            type = "enum",
            name = "Build type",
            order = 3,
            optional = false,
            default = "release",
            choices = { "debug", "release" }
        },
        run_target = {
            type = "string",
            name = "Run target",
            order = 2,
            optional = true,
        },
        target = {
            type = "string",
            name = "Build target",
            order = 1,
            optional = false,
            default = "all",
        },
    },
    builder = function(params)
        local build_dir = require("utils.cmake").get_build_dir(params.compiler, params.build_type)
        local build_target = params.target
        local run_target = params.run_target

        local function isempty(s)
            return s == nil or s == ''
        end

        if isempty(run_target) then
            run_target = build_target
        end

        return {
            name = 'build_and_run_target',
            cmd = { 'cmake' },
            args = { '--build', tostring(build_dir), '--target', build_target },
            components = {
                { "on_output_summarize", max_lines = 10 },
                { "on_exit_set_status" },
                { "on_complete_notify" },
                { "on_output_quickfix",  open = false,  open_on_match = false, open_height = 30 },
                { "unique",              replace = true },
                { "display_duration" },
                { "mynamespace.save_all" },
                {
                    'run_after',
                    task_names = {
                        {
                            'Run target',
                            working_dir = tostring(build_dir) .. '/output',
                            run_target = run_target
                        },
                    },
                }
            }
        }
    end,
}
