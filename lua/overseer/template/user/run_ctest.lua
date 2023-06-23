return {
    name = "Run test",
    params = {
        test_name = {
            type = "string",
            optional = true,
        },
        working_dir = {
            type = "string"
        },
        randomize = {
            type = "boolean",

            name = "randomize",

        },
        repeat_n = {
            type = "integer",
            name = "repeat",
        },
        parallelize = {
            type = "boolean",
            name = "parallelize",
            default = true
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
        local verbosity = ''
        local randomize = ''
        local test_option = ''
        local test_name = ''
        local repeat_n = tostring(params.repeat_n)
        local core_count = '1'

        if params.randomize == true then
            randomize = '--schedule-random'
        end


        if params.test_name == "all" then
            test_option = '-E'
            test_name = ' '
            verbosity = '--progress'
        else
            test_option = '-R'
            test_name = params.test_name
            verbosity = '--verbose'
        end

        if params.parallelize == true then
            core_count = vim.fn.system('nproc')
        end

        return {
            name = 'run ctest',
            cmd = { 'ctest' },
            args = { test_option, test_name, '--output-on-failure', verbosity, randomize, '--repeat-until-fail',
                repeat_n, '--parallel', core_count },
            cwd = params.working_dir
        }
    end
}
