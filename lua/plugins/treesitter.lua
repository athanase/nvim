local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --event = "VeryLazy",
    --event = "BufReadPost",
    event = "BufReadPre",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}

function M.config()
    local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end
    treesitter_configs.setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        autopairs = { enable = true },
        autotag = { enable = true },
        indent = { enable = false, disable = {} },
        ensure_installed = { "c", "cpp", "lua", "vim", "cmake" },
        sync_install = true,
        ignore_install = {}, -- List of parsers to ignore installation
        refactor = {
            highlight_definitions = {
                enable = true,
                clear_on_cursor_move = true,
            },
            highlight_current_scope = { enable = false },
        },
        playground = {
            enable = true,
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?",
            },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<cr>", -- set to `false` to disable one of the mappings
                node_incremental = "<cr>",
                scope_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["<leader>sg"] = "@function.outer",
                    ["<leader>sf"] = "@function.inner",
                    -- ["ac"] = "@class.outer",
                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                    -- nvim_buf_set_keymap) which plugins like which-key display
                    -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    -- You can also use captures from other query groups like `locals.scm`
                    -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                -- selection_modes = {
                --     ['@parameter.outer'] = 'v', -- charwise
                --     ['@function.outer'] = 'V',  -- linewise
                --     ['@class.outer'] = '<c-v>', -- blockwise
                -- },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = true,
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>st"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>sr"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                -- goto_next_start = {
                --     ["]m"] = "@function.outer",
                --     ["]]"] = { query = "@class.outer", desc = "Next class start" },
                --     --
                --     -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                --     ["]o"] = "@loop.*",
                --     -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --     --
                --     -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                --     -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                --     ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                --     ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                -- },
                -- goto_next_end = {
                --     ["]M"] = "@function.outer",
                --     ["]["] = "@class.outer",
                -- },
                -- goto_previous_start = {
                --     ["[m"] = "@function.outer",
                --     ["[["] = "@class.outer",
                -- },
                -- goto_previous_end = {
                --     ["[M"] = "@function.outer",
                --     ["[]"] = "@class.outer",
                -- },
                -- -- Below will go to either the start or the end, whichever is closer.
                -- -- Use if you want more granular movements
                -- -- Make it even more gradual by adding multiple queries and regex.
                -- goto_next = {
                --     ["]d"] = "@conditional.outer",
                -- },
                -- goto_previous = {
                --     ["[d"] = "@conditional.outer",
                -- }
            },
        },
    })
end

return M
