local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands

-- local lsp_utils = require("plugins.lsp.lsp-utils")
-- local capabilities_cpp = lsp_utils.capabilities
-- local cmake_utils = require('tasks.cmake_kits_utils')
-- local function reconfigure_clangd()
--     local clangdArgs = cmake_utils.currentClangdArgs()
--     require('lspconfig')['clangd'].setup({
--         cmd = clangdArgs,
--         on_attach = lsp_utils.on_attach,
--         capabilities = capabilities_cpp,
--         flags = {
--             debounce_text_changes = 500,
--         }
--     })
--     -- vim.api.nvim_command('LspRestart clangd')
-- end

-- Convert the cwd to a simple file name
-- local function get_cwd_as_name()
--     local dir = vim.fn.getcwd(0)
--
--     return dir:gsub("[^A-Za-z0-9]", "_")
-- end
-- local overseer = require("overseer")

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "PersistedSavePre",
    group = config_group,
    callback = function()
        pcall(vim.cmd, "NvimTreeClose")
        -- overseer.save_task_bundle(
        --     get_cwd_as_name(),
        --     -- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
        --     -- pass in the results if you want to save specific tasks.
        --     nil,
        --     { on_conflict = "overwrite" } -- Overwrite existing bundle, if any
        -- )
    end,
})

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "PersistedTelescopeLoadPre",
    group = config_group,
    callback = function()
        vim.schedule(function()
            pcall(vim.cmd, "SessionSave")
            pcall(vim.cmd, "silent %bd!")
        end)
        -- overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
    end,
})

-- vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = "PersistedTelescopeLoadPost",
--     group = config_group,
-- callback = function()
--     vim.schedule(function()
--         vim.diagnostic.reset()
--         pcall(vim.cmd, reconfigure_clangd())
--     end)
-- end,
-- })

vim.api.nvim_create_user_command("OverseerRestartLast", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN, { title = "Overseer" })
    else
        if tasks[1].name == "run target" or tasks[1].name == "run ctest" then
            overseer.run_action(tasks[2], "restart")
        else
            overseer.run_action(tasks[1], "restart")
        end
    end
end, {})

vim.api.nvim_create_user_command("OverseerStopLast", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(tasks[1], "stop")
        local message = "Task canceled: " .. tasks[1].name;
        vim.notify(message, vim.log.levels.INFO, { title = "Overseer" })
    end
end, {})

vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd FileType qf set nobuflisted
    augroup end
]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = config_group,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})
