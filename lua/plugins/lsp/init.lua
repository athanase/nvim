local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
    },
}

function M.config()
    local utils = require("utils")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local lsp_utils = require("plugins.lsp.lsp-utils")

    lsp_utils.setup()

    mason_lspconfig.setup({
        ensure_installed = utils.lsp_servers,
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = lsp_utils.on_attach,
                capabilities = lsp_utils.capabilities,
            })
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
                on_attach = lsp_utils.on_attach,
                capabilities = lsp_utils.capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["pyright"] = function()
            lspconfig.pyright.setup({
                on_attach = lsp_utils.on_attach,
                capabilities = lsp_utils.capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                        },
                    },
                },
            })
        end,
        ["clangd"] = function()
            local capabilities_cpp = lsp_utils.capabilities
            capabilities_cpp.offsetEncoding = { "utf-16" }
            lspconfig.clangd.setup({
                on_attach = lsp_utils.on_attach,
                cmd = {
                    "/opt/llvm-16/bin/clangd",
                    "--background-index",
                },
                capabilities = capabilities_cpp,
                flags = {
                    debounce_text_changes = 500,
                }
            })
        end,
        ["cmake"] = function()
            lspconfig.cmake.setup({
                on_attach = lsp_utils.on_attach,
                capabilities = lsp_utils.capabilities,
                settings = {
                    CMake = {
                        filetypes = { "cmake", "CMakeLists.txt" },
                    },
                },
            })
        end,
    })
end

return M
