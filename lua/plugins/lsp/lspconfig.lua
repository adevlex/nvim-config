return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    config = function()
        local lspconfig = require("lspconfig")

        local M = {}

        M.on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
        end

        M.capabilities = vim.lsp.protocol.make_client_capabilities()

        M.capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }

        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            signs = { text = { [1] = " ", [2] = " ", [3] = " ", [4] = "󰌵" } },
            float = {
                suffix = "",
                header = { "  Diagnostics", "String" },
                prefix = function(_, _, _)
                    return "  ", "String"
                end,
            },
        })

        -- Declarar la clase para las opciones
        ---@class FloatingPreviewOpts
        ---@field border string|"none"|"single"|"double"|"rounded"|"solid"|"shadow" Borde de la ventana.
        ---@field max_width number? Ancho máximo de la ventana.
        ---@field max_height number? Altura máxima de la ventana.
        ---@field focusable boolean? Si la ventana es enfocada o no.

        -- Guardar referencia a la función original
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

        -- Función personalizada
        local function custom_open_floating_preview(contents, syntax, opts, ...)
            ---@type FloatingPreviewOpts
            opts = opts or {}
            opts.border = "solid"

            -- Agregar padding al contenido
            table.insert(contents, 1, " ")
            table.insert(contents, " ")
            for i, line in ipairs(contents) do
                contents[i] = "  " .. line .. "  "
            end

            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Reemplazar la función en vim.lsp.util
        vim.lsp.util.open_floating_preview = custom_open_floating_preview

        local servers = {
            "bashls",
            "jdtls",
            "html",
            "pyright",
            "ts_ls",
            "clangd",
            "cssls",
            "omnisharp",
            "texlab",
            "jsonls",
            "lemminx",
            "tailwindcss",
            "yamlls",
        }

        for _, k in ipairs(servers) do
            lspconfig[k].setup({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
            })
        end

        lspconfig.lua_ls.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,

            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim", "opts", "ft_cmds" },
                    },
                    workspace = {
                        library = {
                            vim.fn.expand("$VIMRUNTIME/lua"),
                            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                            "${3rd}/luv/library",
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        })

        lspconfig.emmet_ls.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            filetypes = {
                "html",
                "css",
                "scss",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
                "php",
                "twig",
            },
            initialize_options = {
                html = {
                    options = {
                        ["bem.enabled"] = true,
                    },
                },
                php = {
                    options = {
                        ["bem.enabled"] = true,
                    },
                },
            },
        })

        lspconfig.intelephense.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            cmd = { "intelephense", "--stdio" },
            root_dir = lspconfig.util.root_pattern("composer.json", ".git", "index.php", "public"),
            filetypes = { "php" },
        })

        lspconfig.clangd.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            cmd = { "clangd", "--background-index" },
            root_dir = lspconfig.util.root_pattern(
                "compile_commands.json",
                "compile_flags.txt",
                "compile_flags.txt",
                "compile_flags.txt"
            ),
        })

        lspconfig.omnisharp.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            cmd = { "omnisharp" },
            root_dir = function()
                return vim.fn.getcwd()
            end,
        })

        lspconfig.efm.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            initialize_options = { documentationFormatting = true },
            settings = {
                rootMarkers = { ".git/" },
                languages = {
                    dosini = {
                        {
                            lintCommand = "ini-lint",
                            lintStdin = true,
                            lintFormats = { "%f:%l:%c: %m" },
                        },
                    },
                },
            },
            filetypes = { "dosini" },
        })

        lspconfig.sqlls.setup({
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            filetypes = { "sql", "mysql" },
            root_dir = function()
                return vim.fn.getcwd()
            end,
            settings = {
                sqlLanguageServer = {
                    connections = {
                        {
                            driver = "mysql",
                            dataSourceName = "root:password@tcp(localhost:3306)/phpmyadmin",
                        },
                    },
                },
            },
        })
        return M
    end,
}
