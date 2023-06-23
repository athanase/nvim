return {
    name = 'Build target',
    priority = 2,
    params = {
        compiler = {
            type = "enum",
            name = "Compiler",
            order = 3,
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
            choices = { "debug", "coverage", "release" }
        },
        target = {
            type = "string",
            name = "Target",
            order = 1,
            optional = false,
            default = "all",
        },
    },
    builder = function(params)
        local build_dir = require("utils.cmake").get_build_dir(params.compiler, params.build_type)
        local target = params.target

        -- local function get_target_names()
        --     -- local build_dir = cmake_utils.getBuildDir()
        --     -- if not build_dir:is_dir() then
        --     --     utils.notify(
        --     --         string.format('Build directory "%s" does not exist, you need to run "configure" task first',
        --     --             build_dir),
        --     --         vim.log.levels.ERROR)
        --     --     return nil
        --     -- end
        --
        --     local reply_dir = cmake_utils.get_reply_dir(cmake_utils.get_main_build_dir())
        --     local codemodel_targets = cmake_utils.get_codemodel_targets(reply_dir)
        --     if not codemodel_targets then
        --         return nil
        --     end
        --
        --     local targets = {}
        --     for _, target in ipairs(codemodel_targets) do
        --         local target_info = cmake_utils.get_target_info(target, reply_dir)
        --         local target_name = target_info['name']
        --         if target_name:find('_autogen') == nil then
        --             table.insert(targets, target_name)
        --         end
        --     end
        --
        --
        --
        --     -- always add 'all' target
        --     table.insert(targets, 'all')
        --     return targets
        -- end
        --
        -- local target_names = getTargetNames()

        return {
            cmd = { 'cmake' },
            args = { '--build', tostring(build_dir), '--target', target },
            name = 'build',
            cwd = '.',
            components = {
                { "on_output_summarize", max_lines = 10 },
                { "on_exit_set_status" },
                { "on_complete_notify" },
                { "on_output_quickfix",  open = false,  open_on_match = false, open_height = 30 },
                { "unique",              replace = true },
                { "display_duration" },
                { "mynamespace.save_all" },
                -- { "mynamespace.launch_dap", build_directory = tostring(build_dir), target = target },
            }
        }
    end,
}
