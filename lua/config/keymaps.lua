local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local function keymap_n(mapping, cmd, description)
    keymap("n", mapping, cmd, { noremap = true, silent = true, desc = description })
end

local function keymap_i(mapping, cmd, description)
    keymap("i", mapping, cmd, { noremap = true, silent = true, desc = description })
end

keymap("n", "<leader><leader>", ":", opts)
keymap("n", "<S-Space>", ":", { noremap = true })
-- keymap("n", "?", ":", opts)

-- Modes normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- Motions
keymap("n", ";", "l", opts)
keymap("n", "j", "h", opts)
keymap("n", "l", "k", opts)
keymap("n", "k", "j", opts)

keymap("v", ";", "l", opts)
keymap("v", "j", "h", opts)
keymap("v", "l", "k", opts)
keymap("v", "k", "j", opts)

keymap("n", "<C-j>", "b", opts)
keymap("n", "<C-;>", "w", opts)

keymap("i", "<C-j>", "<S-left>", opts)
keymap("i", "<C-;>", "<S-right>", opts)

keymap_n("&", "_", opts)
keymap_n("=", "$", opts)

keymap("n", "<C-s>", ":wa<cr>", opts)
keymap("i", "<C-s>", "<esc>:wa<cr>", opts)
keymap("n", "<esc>", ":noh<cr>", opts)

keymap_n("<C-CR>", "o", "Return and insert mode")
keymap_n("<C-A-CR>", "O", "Return and insert mode")

-- vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', opts)

-- Delete word backward
keymap_n("<C-0>", "db", "Delete word backward")
keymap_i("<C-0>", "<C-W>", "Delete word backward")

-- Delete word forward
keymap_n("<C-9>", "dw", "Delete word forward")
keymap_i("<C-9>", "<C-o>dw", "Delete word forward")

vim.keymap.set("n", "<leader>ww", function()
    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- keymap_n("", "", "Delete to the end of the line")
-- keymap_n("", "", "Delete to the end of the line")

-- Visual
-- Stay in indent mod
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- paste without replace clipboard
-- keymap("v", "p", '"_dP', opts)

-- keymap("x", "<C-M-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<C-M-k>", ":move '<-2<CR>gv-gv", opts)

-- keymap("n", "<leader>ww", ":set wrap!<CR>", opts)

-- keymap("n", "<C-M-f>", ':exe "lua vim.lsp.buf.format({async = false})" | exe "w" <CR>', opts)

--keymap("n", "<C-d>", "<C-d>zz", opts)
--keymap("n", "<C-u>", "<C-u>zz", opts)

-- Comment
--keymap_n("<C-/>", "<Plug>(comment_toggle_linewise_current)", "Comment toggle linewise")
--keymap_n("<C-A-/>", "<Plug>(comment_toggle_blockwise_current)", "Comment toggle blockwise")

local wk = require("which-key")
wk.register(
    {
        q = {
            name = "Quit",
            q = { ":xa<cr>", "Save & quit all" },
            a = { ":qa!<cr>", "Discard changes & quit all" },
        },
        w = {
            name = "Window",
            q    = { "<cmd>:close<cr>", "Close window" },
            t    = { ":vsplit<cr>", "Split vertical" },
        },
        f = {
            name = "Find",
            f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find file" },
            w = { "<cmd>lua require'telescope'.extensions.adjacent.adjacent{}<cr>", "Find adjacent file" },
            e = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser{}<cr>", "Browse files" },
            a = {
                "<cmd>lua require('telescope.builtin').buffers()<cr>", "Find buffer" },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
            d = { "<cmd>lua require'telescope'.extensions.search_dir_picker.search_dir_picker{}<cr>",
                "Live grep in directory" },
            b = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Live grep current buffer" },
            r = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Recent Files" },
            s = { "<cmd>lua require'telescope'.extensions.persisted.persisted{}<cr>", "Find session" },
            n = { "New File" },
            -- e = "Edit File", -- same as above
            -- ["1"] = "which_key_ignore", -- special label to hide it in the popup
            -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
        },
        e = {
            name = "NvimTree",
            e = { "<cmd>NvimTreeToggle<cr>", "Toggle tree" },
            r = { "<cmd>lua require('oil').open()<cr>", "Oil open folder" },
            f = { "<cmd>NvimTreeFindFile<cr>", "Focus on file buffer" },
        },
        t = {
            -- f = { "<cmd>ToggleTerm2 direction=float<cr>", "Toggle term float" },
            t = { "<cmd>ToggleTerm2 direction=tab<cr>", "Toggle term horizontal" },
            g = { "<cmd>lua _lazygit_toggle()<cr>", "Toggle lazygit" },
            b = { "<cmd>lua _bottom_toggle()<cr>", "Toggle bottom" },
        },
        r = {
            name = "Replace",
            r = { "*yiw:%s/<C-R>\"//gc<LEFT><LEFT><LEFT>", "Replace text" }
        },
        l = {
            name = "LSP",
            p = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
                "LSP Dynamic workspace symbols" },
            o = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "LSP Document symbold" },
            i = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "LSP References" },
            u = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "LSP Diagnostics" },
            a = { "<cmd>lua require('actions-preview').code_actions()<cr>", "LSP Code actions" },
        },
        c = {
            name = "CMake",
            q = { "<cmd>:OverseerStopLast<cr>", "Cancel" },
            c = { "<cmd>:OverseerClose<cr> :lua require'qf'.toggle('c', false)<cr>", "Toggle quickfix" },
            -- x = { "<cmd>lua require('overseer').toggle({direction = 'bottom'})<cr>", "Toggle overseer" },
            x = { "<cmd>:cclose<cr> :lua require('overseer').toggle()<cr>", "Toggle overseer" },
            f = { "<cmd>OverseerRun<cr>", "Overseer run" },
            -- t = { "<cmd>lua require('overseer').run_template({name = 'Build and run target'})<cr>", "Overseer run" },
            r = { "<cmd>OverseerRestartLast<cr>", "Overseer restart last" },
            k = { "<cmd>:cnext<cr>", "Quickfix next error" },
            l = { "<cmd>:cprevious<cr>", "Quickfix previous error" },
        },
        d = {
            name = "Debug",
            q = { "<cmd>lua require('dap').terminate()<cr>", "Terminate" },
            o = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
            i = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
            j = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
            c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
            k = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Caculate expression" },
            b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
        },
        g = {
            name = "Git",
            g    = { "<cmd>lua _lazygit_toggle()<cr>", "Toggle lazygit" },
            o    = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b    = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c    = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            h    = { "<cmd>:DiffviewFileHistory %<cr>", "Diffview file history" },
            j    = { "<cmd>:DiffviewFileHistory<cr>", "Diffview branch history" },
            k    = { "<cmd>:DiffviewOpen<cr>", "Diffview current" },
            q    = { "<cmd>:DiffviewClose<cr>", "Diffview close" },
        },
        h = {
            name = "Hop",
            h = { "<cmd>lua require'hop'.hint_char1()<cr>", "Hop char 1" },
            j = { "<cmd>lua require'hop'.hint_char2()<cr>", "Hop char 2" },
            k = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop words" },
            l = { "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", "Hop lines" },
            o = { "<cmd>lua require'hop'.hint_anywhere()<cr>", "Hop anywhere" },
            p = { "<cmd>lua require'hop'.hint_patterns()<cr>", "Hop pattern" },
        },
        s = {
            name = "Selection",
            d = { "<cmd>TSTextobjectSelect @function.inner<cr>", "Select function inner" },
            f = { "<cmd>TSTextobjectSelect @function.outer<cr>", "Select function outer" },
            c = { "<cmd>TSTextobjectSelect @class.outer<cr>", "Select class outer" },
            e = { "<cmd>TSTextobjectSelect @loop.inner<cr>", "Select loop inner" },
            r = { "<cmd>TSTextobjectSelect @loop.outer<cr>", "Select loop outer" },
            g = { "<cmd>TSTextobjectSelect @call.inner<cr>", "Select call inner" },
            v = { "<cmd>TSTextobjectSelect @statement.outer<cr>", "Select statement outer" },
            z = { "<cmd>TSTextobjectSelect @conditional.inner<cr>", "Select conditional inner" },
            x = { "<cmd>TSTextobjectSelect @conditional.outer<cr>", "Select conditional outer" },
            w = { "<cmd>TSTextobjectSwapNext<cr>", "Swap parameter next" },
            q = { "<cmd>TSTextobjectSwapPrevious<cr>", "Swap parameter previous" },
        }
    },
    { prefix = "<leader>" }
)
wk.register({
    -- [":"] = { "<cmd>CybuLastusedNext<cr>", "Next last used buffer" },
    -- ["<S-j>"] = { "<cmd>CybuLastusedPrev<cr>", "Previous last used buffer" },
    ["f"]           = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Fuzzy find in buffer" },
    ["t"]           = { "<cmd>CybuNext<cr>", "Next buffer" },
    ["<S-t>"]       = { "<cmd>CybuPrev<cr>", "Prev buffer" },
    ["<S-w>"]       = { "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>", "Buffer close" },

    ["<C-t>"]       = { ":vsplit<cr>", "Split window vertically" },
    ["<C-w>"]       = { ":close<cr>", "Close window" },
    -- Goto window
    ["<C-left>"]    = { ":wincmd h<CR>", "Go to window Left" },
    ["<C-down>"]    = { ":wincmd j<CR>", "Go to window Down" },
    ["<C-up>"]      = { ":wincmd k<CR>", "Go to window Up" },
    ["<C-right>"]   = { ":wincmd l<CR>", "Go to window Right" },
    -- Move window
    ["<C-S-left>"]  = { ":wincmd H<CR>", "Move window Left" },
    ["<C-S-down>"]  = { ":wincmd J<CR>", "Move window Down" },
    ["<C-S-up>"]    = { ":wincmd K<CR>", "Move window Up" },
    ["<C-S-right>"] = { ":wincmd L<CR>", "Move window Right" },
    -- Hop
    ["/"]           = { "<cmd>lua require'hop'.hint_char1({multi_windows = true})<cr>", "Hop char 1" },
    ["m"]           = { "<cmd>lua require'hop'.hint_char2({multi_windows = true})<cr>", "Hop char 2" },
    ["."]           = { "<cmd>lua require'hop'.hint_lines_skip_whitespace({multi_windows = true})<cr>", "Hop lines" },
    ["n"]           = { "<cmd>lua require'hop'.hint_words({multi_windows = true})<cr>", "Hop words" },
    [","]           = { "<cmd>lua require'hop'.hint_patterns({multi_windows = true})<cr>", "Hop pattern" },
    -- ["*"]           = { "<cmd>lua require'hop'.hint_char1()<cr>", "Hop char 1" },
    -- ["("]           = { "<cmd>lua require'hop'.hint_char2()<cr>", "Hop char 2" },
    -- ["&"] = { "<cmd>lua require'hop'.hint_words({multi_windows = true})<cr>", "Hop words" },
    -- ["}"]           = { "<cmd>lua require'hop'.hint_anywhere({multi_windows = true})<cr>", "Hop anywhere" },
    -- Telescope
    ["<C-p>"]       = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
        "LSP Workspace symbols" },
    ["<C-o>"]       = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "LSP Document symbold" },
    ["<C-i>"]       = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "LSP References" },
    ["<C-u>"]       = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Diagnostics" },
    ["<C-b>"]       = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Find buffer" },
    ["<C-f>"]       = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
        "Current buffer fuzzy find" },
    ["<C-g>"]       = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
    ["<C-e>"]       = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    -- Clangd
    ["<C-h>"]       = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source/header" },
    -- ["c"]           = { "<cmd>lua require'qf'.toggle('c', false)<cr>", "Toggle quickfix" },
})

-- keymap("n", "<leader>gd",
--     "<cmd>lua require('user.utils.diff')()<CR>",
--     { desc = "Diff With" }
-- )


-- ToggleTerm
keymap("t", "<leader>th", "<cmd>ToggleTerm direction=float<cr>", opts)
keymap("t", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
keymap("n", "<leader>ta", ":$tabnew<CR>", opts)
keymap("n", "<leader>tq", ":tabclose<CR>", opts)
keymap("n", "<leader>to", ":tabonly<CR>", opts)
keymap("n", "<leader>tn", ":tabn<CR>", opts)
keymap("n", "<leader>tp", ":tabp<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
