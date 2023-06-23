local M = {
    "aaditeynair/conduct.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {

        "ConductNewProject",
        "ConductLoadProject",
        "ConductLoadLastProject",
        "ConductLoadProjectConfig",
        "ConductReloadProjectConfig",
        "ConductDeleteProject",
        "ConductRenameProject",
        "ConductProjectNewSession",
        "ConductProjectLoadSession",
        "ConductProjectDeleteSession",
        "ConductProjectRenameSession",
    },
    event = "VeryLazy",
}

function M.config()
    require("conduct").setup({
        functions = {},
        presets = {},
        hooks = {
            before_session_save = function()
            end,
            before_session_load = function()
            end,
            after_session_load = function()
            end,
            before_project_load = function()
            end,
            after_project_load = function()
            end,
        }
    })
    -- require("telescope").load_extension("persisted") -- To load the telescope extension
end

return M
