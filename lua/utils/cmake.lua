local M = {}

function M.get_compiler_paths(compiler_id)
    if compiler_id == "gcc" then
        return M.get_gcc_compiler_paths()
    elseif compiler_id == "clang" then
        return M.get_clang_compiler_paths()
    end
end

function M.get_gcc_compiler_paths()
    return "/usr/bin/gcc", "/usr/bin/g++"
end

function M.get_clang_compiler_paths()
    return "/opt/llvm-16/bin/clang", "/opt/llvm-16/bin/clang++"
end

function M.generate_cmake_c_compiler_param(c_compiler)
    return "-DCMAKE_C_COMPILER=" .. c_compiler
end

function M.generate_cmake_cxx_compiler_param(cxx_compiler)
    return "-DCMAKE_CXX_COMPILER=" .. cxx_compiler
end

function M.generate_cmake_build_type_param(build_type)
    if build_type == "release" then
        return "-DCMAKE_BUILD_TYPE=Release"
    elseif build_type == 'debug' or build_type == 'coverage' then
        return "-DCMAKE_BUILD_TYPE=Debug"
    end
end

function M.make_query_files(build_dir)
    local query_dir = build_dir / '.cmake' / 'api' / 'v1' / 'query'

    if not query_dir:mkdir({ parents = true }) then
        require("utils").info(string.format('Unable to create "%s"', query_dir.filename))
        return false
    end

    local codemodel_file = query_dir / 'codemodel-v2'

    if not codemodel_file:is_file() then
        if not codemodel_file:touch() then
            require("utils").info(string.format('Unable to create "%s"', codemodel_file.filename))
            return false
        end
    end

    return true
end

-- Calculates the reply directory for CMake File API
-- @param build_dir table: a Path object representing path to CMake binary directory
-- @return table: Path object representing path to CMake File API reply directory
function M.get_reply_dir(build_dir)
    return build_dir / '.cmake' / 'api' / 'v1' / 'reply'
end

function M.get_target_info(codemodel_target, reply_dir)
    return vim.json.decode((reply_dir / codemodel_target['jsonFile']):read())
end

function M.get_codemodel_targets(reply_dir, build_type)
    local scandir = require('plenary.scandir')
    local Path = require('plenary.path')
    local found_files = scandir.scan_dir(reply_dir.filename, { search_pattern = 'codemodel*' })

    if #found_files == 0 then
        require("utils").error('Unable to find codemodel file', vim.log.levels.ERROR)
        return nil
    end

    local codemodel = Path:new(found_files[1])
    local codemodel_json = vim.json.decode(codemodel:read())
    local configurations = codemodel_json['configurations']
    local selectedConfiguration = configurations[1]

    if #configurations > 1 then
        -- multi-config build, select correct configuration
        for _, conf in ipairs(configurations) do
            if build_type == conf['name'] then
                selectedConfiguration = conf
                break
            end
        end
    end

    return selectedConfiguration['targets']
end

function M.get_project_dir()
    return require('plenary.path'):new(vim.fn.getcwd())
end

function M.get_build_dir(compiler, build_type)
    return M.get_main_build_dir() / M.generate_build_dir_name(compiler, build_type)
end

function M.get_main_build_dir()
    return M.get_project_dir() / "build"
end

function M.generate_build_dir_name(compiler, build_type)
    return compiler .. "_" .. build_type
end

return M
