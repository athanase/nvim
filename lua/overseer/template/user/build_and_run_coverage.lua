return {
    name = 'Build and run coverage',
    priority = 1,
    params = {
        compiler = {
            type = "enum",
            name = "Compiler",
            order = 2,
            optional = false,
            default = "gcc",
            choices = { "gcc", "clang" }
        },
    },
    builder = function(params)
        local build_type = 'coverage'
        local cmake_utils = require("utils.cmake")
        local project_dir = cmake_utils.get_project_dir()
        local build_dir = cmake_utils.get_build_dir(params.compiler, build_type)

        build_dir:mkdir({ parents = true })
        cmake_utils.make_query_files(build_dir)

        local c_compiler, cxx_compiler = cmake_utils.get_compiler_paths(params.compiler);

        return {
            name = "cmake_configure",
            cmd = { "cmake" },
            args = {
                "-GNinja",
                "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
                "-DBUILD_WITH_COVERAGE=ON",
                cmake_utils.generate_cmake_c_compiler_param(c_compiler),
                cmake_utils.generate_cmake_cxx_compiler_param(cxx_compiler),
                cmake_utils.generate_cmake_build_type_param(params.build_type),
                "-S",
                tostring(project_dir),
                "-B",
                tostring(build_dir),
            },
            components = {
                { "on_output_summarize", max_lines = 10 },
                { "on_exit_set_status" },
                { "on_complete_notify" },
                { "unique",              replace = true },
                { "display_duration" },
                { "on_output_quickfix",  open_on_match = false },
                {
                    'run_after',
                    task_names = {
                        {
                            'Build target',
                            compiler = params.compiler,
                            build_type = build_type,
                            target = 'all',
                        },
                    },
                },
                -- cmd = { 'cmake' },
                -- args = { '--build', '.', '--target', params.test_name },
                -- cwd = tostring(build_dir),
                -- name = 'build_and_run_coverage',
                -- components = {
                --     { "on_output_summarize", max_lines = 10 },
                --     { "on_exit_set_status" },
                --     { "on_complete_notify" },
                --     { "on_output_quickfix",  open = false,  open_on_match = false, open_height = 30 },
                --     { "unique",              replace = true },
                --     { "display_duration" },
                --     { "mynamespace.save_all" },
                -- -- {
                --     -- 'run_after',
                --     task_names = {
                --         {
                --             'Build target'
                --             'Run test',
                --             working_dir = tostring(build_dir),
                -- --             test_name = params.test_name,
                -- --             randomize = params.randomize,
                -- --             parallelize = params.parallelize,
                -- --             repeat_n = params.repeat_n,
                -- --         },
                -- --     },
                -- -- }
            }
        }
    end,
}
