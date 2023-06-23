local M = {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    event = "BufReadPre",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "MaximilianLloyd/adjacent.nvim" },
        { "smilovanovic/telescope-search-dir-picker.nvim" },
        { "paopaol/telescope-git-diffs.nvim" },
    },
}

function M.config()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
        return
    end

    local my_action = function(prompt_bufnr)
        local action_set = require('telescope.actions.set')
        local action_state = require('telescope.actions.state')
        local picker = action_state.get_current_picker(prompt_bufnr)

        picker.get_selection_window = function(picker, entry)
            local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
            -- Unbind after using so next instance of the picker acts normally
            picker.get_selection_window = nil
            return picked_window_id
        end

        return action_set.edit(prompt_bufnr, 'drop')
    end

    local actions = require("telescope.actions")
    telescope.setup({
        pickers = {
            buffers = {
                -- theme = "dropdown",
                mappings = {
                    i = { ["<CR>"] = my_action }
                },
                path_display = { "tail" },
                ignore_current_buffer = true,
                sort_mru = true,
            },
            find_files = {
                hidden = false,
                mappings = {
                    i = { ["<CR>"] = my_action }
                }
            },
            live_grep = {
                additional_args = function(opts)
                    return { "--hidden" }
                end,
                mappings = {
                    i = { ["<CR>"] = my_action }
                }
            },
            old_files = {
                mappings = {
                    i = { ["<CR>"] = my_action }
                }
            },
            lsp_references =
            {
                fname_width = 60,
                trim_text = true,
                show_line = true,
            },
            lsp_document_symbols = {
                symbol_width = 80,
                symbol_type_width = 10,
                show_line = false,
            },
            lsp_dynamic_workspace_symbols = {
                symbol_width = 40,
                fname_width = 60,
            },
            -- diagnostics = {
            --     layout_strategy = 'vertical',
            --     prompt_position = "top",
            -- },
            -- git_commits = {
            --     mappings = {
            --         i = {
            --             ["<C-o>"] = function(prompt_bufnr)
            --                 actions.close(prompt_bufnr)
            --                 local value = actions.get_selected_entry(prompt_bufnr).value
            --                 vim.cmd('DiffviewOpen ' .. value .. '~1..' .. value)
            --             end,
            --         }
            --     }
            -- }
        },
        defaults = {
            prompt_prefix = "> ",
            selection_caret = "> ",
            path_display = { "smart" },
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.51,
                    results_width = 0.49,
                },
                --     vertical = {
                --         mirror = false,
                --     },
                width = 0.95,
                height = 0.95,
                preview_cutoff = 140,
                scroll_speed = 5,
            },
            mappings = {
                i = {
                    ["<C-q>"] = actions.close,
                    ["<esc>"] = actions.close,
                    ["<C-k>"] = actions.move_selection_next,
                    ["<C-l>"] = actions.move_selection_previous,
                    ["<C-j>"] = actions.preview_scrolling_up,
                    ["<C-;>"] = actions.preview_scrolling_down,
                }
            },
            file_ignore_patterns = {
                ".git/",
                ".cache",
                "%.o",
                "%.a",
                "%.out",
                "%.class",
                "%.pdf",
                "%.mkv",
                "%.mp4",
                "%.zip",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "ignore_case",
            },
            file_browser = {
                hijack_netrw = true,
            },
            adjacent = {
                level = 1
            },
            persisted = {
                layout_config = { width = 0.55, height = 0.55 }
            }
        },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")
    telescope.load_extension("adjacent")
    telescope.load_extension('git_diffs')
    telescope.load_extension('search_dir_picker')
    telescope.load_extension("conduct")
    telescope.load_extension("persisted")
end

return M
