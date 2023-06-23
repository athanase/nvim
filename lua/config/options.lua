vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.timeoutlen = 500
vim.o.timeout = true

vim.api.nvim_create_user_command("UpdateAllPlugins", 'exe "TSUpdate" | exe "Lazy update"', {})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local options = {
    laststatus = 3,
    sidescrolloff = 3,
    scroll = 5,
    scrolloff = 20,
    clipboard = "unnamedplus",
    undofile = true,
    pumheight = 10,
    ignorecase = true,
    smartcase = true,
    smartindent = true,
    showmode = false,
    autoindent = true,
    signcolumn = "yes",
    sessionoptions = "buffers,curdir,tabpages,winpos,winsize",
    completeopt = { "menu", "menuone", "noselect" },
    expandtab = true,
    swapfile = false,
    termguicolors = true,
    updatetime = 100,
    writebackup = false,
    number = true,
    jumpoptions = "view",
    shiftwidth = 4,
    tabstop = 4,
    cmdheight = 0,
    list = true,
    foldcolumn = "0",
    foldenable = false,
    splitkeep = "screen",
    -- syntax = "on",
    -- spell = true,
    -- spelloptions = "camel,noplainbuffer",
    cursorline = true,
    wildmode = "longest:full:full",
    wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db",
    backup = false,   -- creates a backup file
    autoread = true,  -- when file changed, autoread it
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8",
    hlsearch = true,
    incsearch = true,
    mouse = "a",           -- allow the mouse to be used in neovim
    -- showtabline = 0, -- don't show tabs
    splitbelow = true,     -- force all horizontal splits to go below current window
    splitright = true,     -- force all vertical splits to go to the right of current window
    relativenumber = true, -- set relative numbered lines
    numberwidth = 3,       -- set number column width to 2 {default 4}
    errorbells = false,    -- no error bells
    title = true,          -- show title in terminal header
    switchbuf = "useopen,uselast",
    fillchars = {
        diff = "╱",
        fold = " ",
        eob = " ",
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┫",
        vertright = "┣",
        verthoriz = "╋",
        foldclose = "",
        foldopen = "",
        foldsep = " ",
    },
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
