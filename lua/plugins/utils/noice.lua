return
{
    'folke/noice.nvim',
    event = 'CmdlineEnter',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = function()
        local ok, noice = pcall(require, "noice")
        if not ok then return end

        noice.setup({
            lsp = {
                progress = {
                    enabled = false,                   -- Deshabilita la barra de progreso de LSP
                    format = "lsp_progress",           -- Formato de la barra de progreso LSP
                    format_done = "lsp_progress_done", -- Formato cuando el progreso está completo
                    throttle = 1000 / 30,              -- Frecuencia para actualizar el mensaje de progreso LSP
                    view = "mini",                     -- Vista de la barra de progreso (miniatura)
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- Usa el formateador de Markdown de Noice
                    ["vim.lsp.util.stylize_markdown"] = true,                -- Usa el formateador de Markdown de Noice
                    ["cmp.entry.get_documentation"] = true,                  -- Usa la documentación de Noice para cmp
                },
                hover = {
                    enabled = false, -- Deshabilita la función de "hover"
                    silent = false,  -- Mostrar mensaje incluso si "hover" no está disponible
                    view = nil,      -- Utiliza la vista predeterminada
                    opts = {},       -- Opciones mezcladas con las predeterminadas
                },
                signature = {
                    enabled = false,    -- Deshabilita la función de firma
                    auto_open = {
                        enabled = true, -- Abre automáticamente la ayuda de firma
                        trigger = true, -- Muestra la ayuda de firma al escribir un carácter de activación
                        luasnip = true, -- Abre la ayuda de firma al saltar a nodos Luasnip
                        throttle = 50,  -- Retraso de 50ms para las solicitudes de ayuda de firma
                    },
                    view = nil,         -- Utiliza la vista predeterminada
                    opts = {},          -- Opciones mezcladas con las predeterminadas
                },
                message = {
                    enabled = true,  -- Habilita los mensajes de los servidores LSP
                    view = "notify", -- Utiliza la vista "notify" para los mensajes
                    opts = {},       -- Opciones de la vista de mensajes
                },
                documentation = {
                    view = "hover",               -- Utiliza la vista de "hover" para la documentación
                    opts = {
                        lang = "markdown",        -- Lenguaje Markdown para la documentación
                        replace = true,           -- Reemplaza la documentación existente
                        render = "plain",         -- Renderiza la documentación en formato plano
                        format = { "{message}" }, -- Formato de la documentación
                        win_options = {
                            concealcursor = "n",
                            conceallevel = 3,
                        }, -- Opciones de ventana
                    },
                },
            },
            presets = {
                bottom_search = true,         -- Usa la línea de comandos inferior para buscar
                command_palette = true,       -- Posiciona la línea de comandos y el menú emergente juntos
                long_message_to_split = true, -- Muestra mensajes largos en una división
                inc_rename = false,           -- Deshabilita el diálogo de renombrado incremental
                lsp_doc_border = true,        -- Agrega un borde a las ventanas emergentes de documentación y firma
            },
        })
    end,
}
