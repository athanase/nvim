return {
    name = "CMake configure",
    builder = function(params)
        local cmake_utils = require("utils.cmake")
        local project_dir = cmake_utils.get_project_dir()
        local build_dir = cmake_utils.get_build_dir(params.compiler, params.build_type)

        build_dir:mkdir({ parents = true })
        cmake_utils.make_query_files(build_dir)

        local c_compiler, cxx_compiler = cmake_utils.get_compiler_paths(params.compiler);

        return {
            name = "cmake_configure",
            cmd = { "cmake" },
            args = {
                "-GNinja",
                "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
                cmake_utils.generate_cmake_c_compiler_param(c_compiler),
                cmake_utils.generate_cmake_cxx_compiler_param(cxx_compiler),
                cmake_utils.generate_cmake_build_type_param(params.build_type),
                "-S",
                tostring(project_dir),
                "-B",
                tostring(build_dir),
            },
            components = {
                { "on_output_summarize",         max_lines = 10 },
                { "on_exit_set_status" },
                { "on_complete_notify" },
                { "unique",                      replace = true },
                { "display_duration" },
                { "on_output_quickfix",          open_on_match = false },
                { "mynamespace.reconfigure_lsp", build_directory = tostring(build_dir) },
            },
        }
    end,
    priority = 2,
    params = {
        compiler = {
            type = "enum",
            name = "Compiler",
            order = 1,
            optional = false,
            default = "gcc",
            choices = { "gcc", "clang" }
        },
        build_type = {
            type = "enum",
            name = "Build type",
            order = 2,
            optional = false,
            default = "release",
            choices = { "debug", "release", "coverage" }
        }
    }
}
