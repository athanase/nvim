return {
    name = 'Build and run ctest',
    priority = 1,
    params = {
        test_name = {
            type = "string",
            name = "Test name",
            order = 1,
            optional = false,
            default = "all"
        },
        randomize = {
            type = "boolean",
            name = "randomize",
            default = false,
            order = 2,
        },
        parallelize = {
            type = "boolean",
            name = "parallelize",
            default = true,
            order = 3,
        },
        repeat_n = {
            type = "integer",
            name = "repeat",
            default = 1,
            order = 4,
        },
        build_type = {
            type = "enum",
            name = "Build type",
            order = 5,
            optional = false,
            default = "release",
            choices = { "debug", "release" }
        },
        compiler = {
            type = "enum",
            name = "Compiler",
            order = 6,
            optional = false,
            default = "gcc",
            choices = { "gcc", "clang" }
        },
    },
    builder = function(params)
        local build_dir = require("utils.cmake").get_build_dir(params.compiler, params.build_type)

        return {
            cmd = { 'cmake' },
            args = { '--build', tostring(build_dir), '--target', params.test_name },
            name = 'build_and_test',
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
                            'Run test',
                            working_dir = tostring(build_dir),
                            test_name = params.test_name,
                            randomize = params.randomize,
                            parallelize = params.parallelize,
                            repeat_n = params.repeat_n,
                        },
                    },
                }
            }
        }
    end,
}
