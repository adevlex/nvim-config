return
{
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")

        local options = {
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },

                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>",
                },
            },

            max_concurrent_installers = 10,
        }

        mason.setup(options)

        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "emmet_ls",
                "pyright",
                "clangd",
                "omnisharp"
            },
        }
    end
}
