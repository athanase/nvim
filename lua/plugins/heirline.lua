local M = {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    enabled = false,
}

function M.config()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local colors = {
        bright_bg = utils.get_highlight("Folded").bg,

        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,

        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
    }

    local ViMode = {
        init = function(self)
            self.mode = vim.fn.mode(1) -- :h mode()
        end,
        static = {
            mode_names = {
                -- change the strings if you like it vvvvverbose!
                n = "N",
                no = "N?",
                nov = "N?",
                noV = "N?",
                ["no\22"] = "N?",
                niI = "Ni",
                niR = "Nr",
                niV = "Nv",
                nt = "Nt",
                v = "V",
                vs = "Vs",
                V = "V_",

                Vs = "Vs",
                ["\22"] = "^V",
                ["\22s"] = "^V",
                s = "S",

                S = "S_",
                ["\19"] = "^S",
                i = "I",
                ic = "Ic",
                ix = "Ix",
                R = "R",
                Rc = "Rc",
                Rx = "Rx",

                Rv = "Rv",
                Rvc = "Rv",
                Rvx = "Rv",
                c = "C",
                cv = "Ex",
                r = "...",
                rm = "M",
                ["r?"] = "?",
                ["!"] = "!",

                t = "T",
            },
            mode_colors = {
                n = "red",
                i = "green",
                v = "cyan",
                V = "cyan",
                ["\22"] = "cyan",
                c = "orange",
                s = "purple",
                S = "purple",
                ["\19"] = "purple",
                R = "orange",
                r = "orange",
                ["!"] = "red",
                t = "red",
            }
        },
        provider = function(self)
            return " %2(" .. self.mode_names[self.mode] .. "%)"
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, }
        end,
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function()
                vim.cmd("redrawstatus")
            end),
        }
    }

    local Align = { provider = "%=" }
    local Space = { provider = " " }

    local FileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
    }

    local FileIcon = {
        init = function(self)
            local filename = self.filename

            local extension = vim.fn.fnamemodify(filename, ":e")
            self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
                { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. " ")
        end,
        hl = function(self)
            return { fg = self.icon_color }
        end
    }

    local FileName = {
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then return "[No Name]" end
            if not conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return filename
        end,
        hl = { fg = utils.get_highlight("Directory").fg },
    }

    local FileFlags = {
        {
            condition = function()
                return vim.bo.modified
            end,
            provider = "[+]",
            hl = { fg = "green" },
        },
        {
            condition = function()
                return not vim.bo.modifiable or vim.bo.readonly
            end,
            provider = "",
            hl = { fg = "orange" },
        },
    }

    local FileNameModifer = {
        hl = function()
            if vim.bo.modified then
                -- use `force` because we need to override the child's hl foreground

                return { fg = "cyan", bold = true, force = true }
            end
        end,
    }

    FileNameBlock = utils.insert(FileNameBlock,
        FileIcon,
        utils.insert(FileNameModifer, FileName),
        FileFlags,
        { provider = '%<' }
    )

    local FileType = {
        provider = function()
            return string.upper(vim.bo.filetype)
        end,
        hl = { fg = utils.get_highlight("Type").fg, bold = true },
    }

    local FileEncoding = {
        provider = function()
            local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
            return enc ~= 'utf-8' and enc:upper()
        end
    }

    local FileFormat = {
        provider = function()
            local fmt = vim.bo.fileformat
            return fmt ~= 'unix' and fmt:upper()
        end

    }

    local FileSize = {
        provider = function()
            local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
            local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
            fsize = (fsize < 0 and 0) or fsize
            if fsize < 1024 then
                return fsize .. suffix[1]
            end
            local i = math.floor((math.log(fsize) / math.log(1024)))
            return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
        end
    }
    local FileLastModified = {
        provider = function()
            local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
            return (ftime > 0) and os.date("%c", ftime)
        end
    }
    local ScrollBar = {
        static = {
            sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
            -- Another variant, because the more choice the better.
            -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
        },
        provider = function(self)
            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
            return string.rep(self.sbar[i], 2)
        end,
        hl = { fg = "blue", bg = "bright_bg" },
    }

    local Ruler = {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %P = percentage through file of displayed window
        provider = "%7(%l/%3L%):%2c %P",
    }

    ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode, Snippets })

    local DefaultStatusline = {
        ViMode, Space, FileNameBlock, Space, Git, Space, Diagnostics, Align,

        Navic, DAPMessages, Align,
        LSPActive, Space, LSPMessages, Space, UltTest, Space, FileType, Space, Ruler, Space, ScrollBar

    }

    local TerminalName = {
        provider = function()
            local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
            return " " .. tname
        end,
        hl = { fg = "blue", bold = true },
    }

    local WinBars = {
        fallthrough = false,
        {
            -- A special winbar for terminals
            condition = function()
                return conditions.buffer_matches({ buftype = { "terminal" } })
            end,
            utils.surround({ "", "" }, "#555555", {
                FileType,
                Space,
                TerminalName,
            }),
        },
        {
            condition = function()
                return not conditions.is_active()
            end,
            utils.surround({ "", "" }, "#073642", { hl = { fg = "#657b83", force = true }, FileNameBlock }),
        },
        -- utils.surround({ " TEST", "" }, "#222222", FileNameBlock),
        utils.surround({ "", "" }, "#268bd2", { hl = { fg = "#002b36", force = true }, FileNameBlock }),
    }

    require("heirline").setup({
        winbar = WinBars,
        opts = {
            disable_winbar_cb = function(args)
                return conditions.buffer_matches({
                    buftype = { "nofile", "prompt", "help", "quickfix" },
                    filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
                }, args.buf)
            end,
        },
    })
end

return M
