local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- enabled = false,
}

function M.config()
    vim.g.lualine_buffer_silence = true
    local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end

    local location = { "location", padding = 0 }
    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            section_separators = { left = " ", right = " " },
            component_separators = { left = "", right = "" },
            disabled_filetypes = {
                "alpha",
                "dashboard",
                statusline = {},
                winbar = {
                    "fugitive",
                    "COMMIT_EDITMSG",
                    "Trouble",
                    "NvimTree",
                    "diffview",
                    "Diffview*",
                    "help",
                    ".git",
                    "DiffviewFiles",
                    "DiffviewFileHistory",
                    "dap-repl",
                    "dapui_console",
                    "dapui_watches",
                    "dapui_stacks",
                    "dapui_breakpoints",
                    "dapui_scopes",
                    "qf",
                    "OverseerList",
                    "toggleterm",
                },
            },
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                {
                    "branch",
                    icon = " ",
                    color = { fg = "#6c71c4", gui = "bold" },
                    padding = { left = 4, right = 2 },
                },
                {
                    "diff",
                    colored = true,
                    symbols = {
                        added = " ",
                        modified = " ",
                        removed = " ",
                    },
                    source = diff_source,
                    padding = { left = 0, right = 4 },
                },
            },
            lualine_c = {
                {
                    "filetype",
                    colored = false,  -- Displays filetype icon in color if set to true
                    icon_only = true, -- Display only an icon for filetype
                    color = { fg = "#586e75", gui = "none" },
                },
                {
                    "filename",
                    path = 1,
                    color = { fg = "#586e75", gui = "none" },
                },
                {
                    "filesize",
                    color = { fg = "#586e75", gui = "none" },
                },
                {
                    "encoding",
                    color = { fg = "#586e75", gui = "none" },
                },

            },
            lualine_x = {
                {
                    icon = "  Tasks:",
                    color = { fg = "#268bd2", gui = "none" },
                    function()
                        local overseer = require("overseer")
                        local tasks = overseer.list_tasks({ recent_first = true })
                        if vim.tbl_isempty(tasks) then
                            return "none"
                        else
                            return tasks[1].name
                        end
                    end,
                },
                {
                    "overseer",
                    colored = true,
                    padding = { left = 0, right = 4 },
                },
            },
            lualine_y = {
                {
                    function()
                        local msg = "None"
                        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,
                    icon = " LSP:",
                    color = { fg = "#2aa198", gui = "none" },
                },
                {
                    "diagnostics",
                    padding = { left = 0, right = 4 },
                }
            },
            lualine_z = {
                "progress",
                location
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { location },
        },
        winbar = {
            lualine_a = { {
                "buffers",
                symbols = {
                    alternate_file = "",
                },
                icons_enabled = false,
            } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        inactive_winbar = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},

            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            'quickfix',
            'fugitive',
            'nvim-tree',
            'toggleterm',
            'nvim-dap-ui',
            'overseer',
            'lazy'
        },
    })
end

return M
