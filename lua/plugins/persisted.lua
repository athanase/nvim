local M = {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
}

local CloseAllFloatingWindows = function()
    local closed_windows = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= "" then          -- is_floating_window?
            vim.api.nvim_win_close(win, false) -- do not force
            table.insert(closed_windows, win)
        end
    end
    print(string.format('Closed %d windows: %s', #closed_windows, vim.inspect(closed_windows)))
end

function M.config()
    require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = true,                                                    -- silent nvim message when sourcing session file
        use_git_branch = false,                                           -- create session files based on the branch of the git enabled repository
        autosave = true,                                                  -- automatically save session files when exiting Neovim
        should_autosave = function()
            if vim.bo.filetype == "alpha" then
                return false
            end
            return true
        end,
        autoload = true, -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = function()
            vim.notify("No existing session to load.")
        end,
        follow_cwd = false, -- change session file name to match current working directory if it changes
        allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
        -- after_source = function()
        --     vim.notify("Loaded session")
        -- end,
        -- telescope = {
        --     reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
        before_source = function()
            CloseAllFloatingWindows()
            --     vim.api.nvim_input("<Esc><Cmd>%bd<CR>")
        end,
        -- after_source = function()
        --     vim.notify(
        --     -- "Loaded session " .. session.name,
        --     -- vim.log.levels.INFO,
        --     -- { title = title }
        --     )
        -- end,
        -- },
    })
end

return M
