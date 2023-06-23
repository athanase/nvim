local M = {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
}

function M.config()
    require("overseer").setup({
        dap = true,
        strategy = {
            "toggleterm",
            open_on_start = false,
            direction = "tab",
            shade_terminals = false,
        },
        form = {
            border = "rounded",
            zindex = 40,
            -- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_X and max_X can be a single value or a list of mixed integer/float types.
            min_width = 80,
            max_width = 0.9,
            width = nil,
            min_height = 10,
            max_height = 0.9,
            height = nil,
            -- Set any window options here (e.g. winhighlight)
            win_opts = {
                winblend = 0,
            },
        },
        task_win = {
            padding = 2,
            border = "rounded",
            win_opts = {
                winblend = 0,
            },
        },
        templates = {
            "user.configure_cmake",
            "user.build",
            "user.build_and_run_target",
            "user.build_and_run_ctest",
            "user.build_and_run_coverage",
            "user.run_target",
            "user.run_ctest",
        },
        task_list = {
            default_detail = 2,
            max_height = 20,
            -- direction = 'bottom'
            -- min_height = 8,
            -- height = 8,
            bindings = {
                ["<CR>"] = "RunAction",
                ["<C-e>"] = "Edit",
                ["o"] = "Open",
                -- ["<C-v>"] = "OpenVsplit",
                -- ["<C-s>"] = "OpenSplit",
                -- ["<C-f>"] = "OpenFloat",
                -- ["<C-q>"] = "OpenQuickFix",
                ["p"] = "TogglePreview",

                -- ["<C-l>"] = "IncreaseDetail",
                -- ["<C-h>"] = "DecreaseDetail",
                -- ["L"] = "IncreaseAllDetail",
                -- ["H"] = "DecreaseAllDetail",

                -- ["["] = "DecreaseWidth",
                -- ["]"] = "IncreaseWidth",
                ["L"] = "PrevTask",
                ["K"] = "NextTask",
                ["J"] = "ScrollOutputUp",
                [";"] = "ScrollOutputDown",
            },
        }
    })

    local overseer = require("overseer")

    -- overseer.add_template_hook(
    --     { name = "cargo clean" },
    --     function(task_defn, util)
    --         util.remove_component(task_defn, "on_complete_notify")
    --     end
    -- )

    -- -- get the list of branches and offer to pick one
    -- require('overseer').register_template(
    --     {
    --         name = "branch-using-task",
    --         cache_key = function(opts)
    --             return "branch-using-task"
    --         end,
    --         generator = function(opts, cb)
    --             local branches = {}
    --             local jid = vim.fn.jobstart({
    --                     "git",
    --                     "branch",
    --                     "--sort=-committerdate",
    --                     "--format=%(refname:short)"
    --                 },
    --                 {
    --                     cwd = opts.dir,
    --                     stdout_buffered = true,
    --                     on_stdout = vim.schedule_wrap(function(j, output)
    --                         for _, line in ipairs(output) do
    --                             table.insert(branches, line)
    --                         end
    --                     end),
    --                     on_exit = vim.schedule_wrap(function(j, output)
    --                         cb({
    --                             {
    --                                 name = "name of the task",
    --                                 params = {
    --                                     branch = { type = "enum", choices = branches },
    --                                 },
    --                                 builder = function(params)
    --                                     local args = { "rake taskname" }
    --                                     return {
    --                                         cmd = { 'rake' },
    --                                         args = args,
    --                                         env = {
    --                                             BRANCH = params['branch'],
    --                                         },
    --                                     }
    --                                 end,
    --                             }
    --                         })
    --                     end)
    --                 })
    --             if jid == 0 then
    --                 log:error("Passed invalid arguments to 'git'")
    --                 cb({})
    --             elseif jid == -1 then
    --                 log:error("'git' is not executable")
    --                 cb({})
    --             end
    --         end
    --     })
end

return M
