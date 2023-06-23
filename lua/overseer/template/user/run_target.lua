return {
    name = "Run target",
    params = {
        run_target = {
            type = "string"
        },
        working_dir = {
            type = "string"
        },
    },
    components = {
        { "on_output_summarize", max_lines = 10 },
        { "on_exit_set_status" },
        { "on_complete_notify" },
        { "unique",              replace = true },
        { "display_duration" }
    },
    builder = function(params)
        local cmd = './' .. params.run_target
        return {
            name = 'run target',
            cmd = cmd,
            cwd = params.working_dir
        }
    end
}
