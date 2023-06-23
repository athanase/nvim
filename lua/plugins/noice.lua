local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
}

-- function M.config()
--     require("noice").setup({
--         lsp = {
--             override = {
--                 -- override the default lsp markdown formatter with Noice
--                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--                 -- override the lsp markdown formatter with Noice
--                 ["vim.lsp.util.stylize_markdown"] = true,
--                 -- override cmp documentation with Noice (needs the other options to work)
--                 ["cmp.entry.get_documentation"] = true,
--             },
--         },
--         views = {
--             cmdline_popup = {
--                 position = {
--                     row = "40%",
--                     col = "50%",
--                 },
--                 size = {
--                     width = 60,
--                     height = "auto",
--                 },
--             },
--             popupmenu = {
--                 relative = "editor",
--                 position = {
--                     row = "50%",
--                     col = "50%",
--                 },
--                 size = {
--                     width = 60,
--                     height = 10,
--                 },
--                 border = {
--                     style = "rounded",
--                     padding = { 0, 1 },
--                 },
--                 win_options = {
--                     winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
--                 },
--             }
--         },
--     })
-- end

function M.config()
    require("noice").setup({
        cmdline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {},              -- global options for the cmdline. See section on views
            format = {
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
                search_down = {
                    kind = "search",
                    pattern = "^/",
                    icon = " ",
                    lang = "regex",
                },
                search_up = {
                    kind = "search",
                    pattern = "^%?",
                    icon = " ",
                    lang = "regex",
                },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = {
                    pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                    icon = "",
                    lang = "lua",
                },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = {}, -- Used by input()
                -- lua = false, -- to disable a format, set to `false`
            },
        },
        messages = {
            enabled = true,              -- enables the Noice messages UI
            view = "notify",             -- default view for messages
            view_error = "notify",       -- view for errors
            view_warn = "notify",        -- view for warnings
            view_history = "messages",   -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
            enabled = true,  -- enables the Noice popupmenu UI
            backend = "nui", -- backend to use to show regular cmdline completions
            kind_icons = {}, -- set to `false` to disable icons
        },
        redirect = {
            view = "popup",
            filter = { event = "msg_show" },
        },
        commands = {
            history = {
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp",      kind = "message" },
                    },
                },
            },
            last = {
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp",      kind = "message" },
                    },
                },
                filter_opts = { count = 1 },
            },
            errors = {
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = { error = true },
                filter_opts = { reverse = true },
            },
        },
        notify = {
            enabled = true,
            view = "notify",
        },
        lsp = {
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false,
            },
            hover = {
                enabled = true,
                view = nil,
                opts = { border = "rounded" },
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = false,           -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true,            -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50,             -- Debounce lsp signature help request by 50ms
                },
                view = nil,                    -- when nil, use defaults from documentation
                opts = { border = "rounded" }, -- merged with defaults from documentation
            },
            message = {
                enabled = true,
                view = "mini",
                opts = {},
            },
            documentation = {
                view = "hover",
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },
        markdown = {
            hover = {
                ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
                ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
            },
            highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s(Parameters:)"] = "@text.title",
                ["^%s(Return:)"] = "@text.title",
                ["^%s(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
            },
        },
        health = {
            checker = true, -- Disable if you don't want health checks to run
        },
        presets = {
            bottom_search = false,         -- use a classic bottom cmdline for search
            command_palette = true,        -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = true,             -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,        -- add a border to hover docs and signature help
        },
        throttle = 1000 / 30,              -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        views = {
            cmdline = {
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
                },
            },
            cmdline_popup = {
                position = {
                    row = "40%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
        routes = {
            {
                view = "mini",
                filter = {
                    any = {
                        -- { event = "msg_showmode" }, -- see :h showmode| messages like recorind @x
                        { find = "Config Change Detected" },        -- to use string.find() on message
                        { find = " written" },                      -- to use string.find() on message
                        { find = " change" },                       -- to use string.find() on message
                        { find = "LSP reconfigured" },              -- to use string.find() on message
                        { find = "You cannot close the last tab" }, -- to use string.find() on message
                        { find = " written" },
                        { find = "Hop 1 char:" },
                        { find = "Hop 2 char:" },
                        { find = "Config Changed Detected" },
                        { event = "msg_history_show" },                           -- for :messages output
                        { event = "msg_show",                    kind = "wmsg" }, -- see :h W10
                        { find = "E486" },                                        -- see :h E486
                        { event = "msg_showcmd",                 find = "[%d]" },
                    },
                },
            },
            {
                filter = {
                    any = {
                        { event = "msg_show",                          find = "Select a command" }, -- select ui
                        { find = "exit code" },
                        { find = "ID already taken" },
                        { find = "No client with id" },
                        { event = "msg_show",                          max_length = 1 },  -- don't show messages with no body
                        { event = "msg_show",                          find = "indent" }, -- ignore indentations messages
                        { find = "No information available" },                            -- lsp no more information messages
                        { find = "Special characters must be escaped " },                 -- show the ale linting errors
                        { find = "No code actions available" },                           -- skip no code actions notifications
                        -- { find = "Pick window:" },                                        -- ignore this message from nvim-window-picker
                    },
                },
                opts = { skip = true },
            },
        },
        status = {},
        format = {},
    })
end

return M
