return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        local present, cmp = pcall(require, "cmp")
        if not present then
            return
        end

        local kind_icons = {
            Array = " 󰅪 ", -- Representa una lista o conjunto de datos
            Boolean = " 󰨊 ", -- Booleanos
            Class = " 󰠱 ", -- Clases
            Color = " 󰏘 ", -- Representación de colores
            Constant = " 󰏿 ", -- Constantes
            Constructor = " 󰆧 ", -- Constructores
            Enum = " 󰕘 ", -- Enumeraciones
            EnumMember = " 󰕣 ", -- Miembros de enumeraciones
            Event = " 󰘉 ", -- Eventos
            Field = " 󰇾 ", -- Campos
            File = " 󰈙 ", -- Archivos
            Folder = " 󰉋 ", -- Carpetas
            Function = " 󰊕 ", -- Funciones
            Interface = " 󰋱 ", -- Interfaces
            Key = " 󰌋 ", -- Claves
            Keyword = " 󰇠 ", -- Palabras clave
            Method = " 󰊕 ", -- Métodos
            Module = " 󰌗 ", -- Módulos
            Namespace = " 󰅪 ", -- Espacios de nombres
            Null = " 󰟢 ", -- Valor nulo
            Number = " 󰉹 ", -- Números
            Object = " 󰇧 ", -- Objetos
            Operator = " 󰆕 ", -- Operadores
            Package = " 󰏓 ", -- Paquetes
            Property = " 󰓹 ", -- Propiedades
            Reference = " 󰦪 ", -- Referencias
            Snippet = " 󰲡 ", -- Fragmentos
            String = " 󰀬 ", -- Cadenas
            Struct = " 󰖸 ", -- Estructuras
            Text = " 󰈶 ", -- Texto
            TypeParameter = " 󰗵 ", -- Parámetros de tipo
            Unit = " 󰑑 ", -- Unidades
            Value = " 󰠡 ", -- Valores
            Variable = " 󰡦 ", -- Variables
            Supermaven = " 󰗚 ", -- Icono especial para personalización
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    local ok, luasnip = pcall(require, "luasnip")
                    if ok then
                        luasnip.lsp_expand(args.body)
                    end
                end,
            },

            window = {
                completion = {
                    border = "rounded",
                    scrollbar = false,
                    winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                },
                documentation = {
                    border = "rounded",
                    scrollbar = false,
                    winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Esc>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = kind_icons[vim_item.kind]
                    vim_item.menu = ({
                        buffer = "󰈔  Buf",
                        path = "󰉖  Pat",
                        nvim_lsp = "󰒕  Lsp",
                        luasnip = "󰜷  Snp",
                        cmdline = "  Cmd",
                        nvim_lua = "  Lua",
                        supermaven = "󱎑  Aic",
                    })[entry.source.name]

                    local api = vim.api
                    local cmp_ui = {
                        icons_left = false,
                        lspkind_text = true,
                        format_colors = {
                            tailwind = false,
                            icon = "󱓻 ",
                        },
                    }

                    local colors_icon = "󱓻 " .. " "

                    local format_kk = function(entr, item)
                        local entryItem = entr:get_completion_item()
                        local color = entryItem.documentation

                        if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
                            local hl = "hex-" .. color:sub(2)

                            if #api.nvim_get_hl(0, { name = hl }) == 0 then
                                api.nvim_set_hl(0, hl, { fg = color })
                            end

                            item.kind = cmp_ui.icons_left and colors_icon or " " .. colors_icon
                            item.kind_hl_group = hl
                            item.menu_hl_group = hl
                        end
                    end

                    if cmp_ui.format_colors.tailwind then
                        format_kk(entry, vim_item)
                    end
                    return vim_item
                end,
            },

            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "luasnip_choice" },
                { name = "snippy" },
                { name = "nvim_lua" },
                { name = "vsnip" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "supermaven" },
            }),
        })
    end,
}
