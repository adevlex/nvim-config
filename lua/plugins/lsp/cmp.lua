return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
    },
    config = function()
        local present, cmp = pcall(require, 'cmp')
        if not present then
            return
        end

        local kind_icons = {
            Array = " 󰅪 ",
            Boolean = " 󰡘 ",
            Class = " 󱓑 ",
            Color = " 󰸌 ",
            Constant = " 󱡠 ",
            Constructor = " 󰆣 ",
            Enum = " 󰉛 ",
            EnumMember = " 󰐂 ",
            Event = " 󱓷 ",
            Field = " 󰛻 ",
            File = " 󰷪 ",
            Folder = " 󰉑 ",
            Function = " 󰡴 ",
            Interface = " 󰧞 ",
            Key = " 󰌠 ",
            Keyword = " 󰉠 ",
            Method = " 󰟔 ",
            Module = " 󰏦 ",
            Namespace = " 󰅗 ",
            Null = " 󰠗 ",
            Number = " 󰎔 ",
            Object = " 󰠌 ",
            Operator = " 󰆽 ",
            Package = " 󰒒 ",
            Property = " 󰜢 ",
            Reference = " 󰛉 ",
            Snippet = " 󱋖 ",
            String = " 󰉾 ",
            Struct = " 󱓟 ",
            Text = " 󰉡 ",
            TypeParameter = " 󰒅 ",
            Unit = " 󰣺 ",
            Value = " 󱈄 ",
            Variable = " 󰡧 ",
            Codeium = " 󱓑 ",
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
                    border = "solid",
                    scrollbar = false,
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
                },
                documentation = {
                    border = "solid",
                    scrollbar = false,
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
                }
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Esc>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.kind = kind_icons[vim_item.kind]

                    local colors = require("theme").getCurrentTheme()
                    local utils = require("core.utils")

                    if not colors then
                        return { error = "colors not found" }
                    end

                    local menu_colors = {
                        buffer = { fg = colors.base0C, bg = utils.blend(colors.base03, colors.darker, 0.3) },   -- Celeste sólido y fondo oscuro
                        path = { fg = colors.base0A, bg = utils.blend(colors.base02, colors.darker, 0.3) },     -- Amarillo sólido
                        nvim_lsp = { fg = colors.base09, bg = utils.blend(colors.base03, colors.darker, 0.3) }, -- Naranja sólido
                        luasnip = { fg = colors.base0D, bg = utils.blend(colors.base04, colors.darker, 0.3) },  -- Azul sólido
                        cmdline = { fg = colors.base0E, bg = utils.blend(colors.base05, colors.darker, 0.3) },  -- Magenta sólido
                        nvim_lua = { fg = colors.base0B, bg = utils.blend(colors.base06, colors.darker, 0.3) }, -- Verde sólido
                        codeium = { fg = colors.base08, bg = utils.blend(colors.base02, colors.darker, 0.3) },  -- Rojo sólido
                    }

                    -- Aplicar colores de fg y bg
                    local current_menu = menu_colors[entry.source.name] or { fg = colors.base05, bg = colors.darker }
                    vim_item.menu = string.format("%%#CmpItemMenu# %s", vim_item.menu)

                    -- Definir el highlight para el menú dinámicamente
                    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = current_menu.fg, bg = current_menu.bg })


                    vim_item.menu = ({
                        buffer = "󰈔  [Buf]",
                        path = "󰉖  [Pat]",
                        nvim_lsp = "󰒕  [Lsp]",
                        luasnip = "󰜷  [Snp]",
                        cmdline = "  [Cmd]",
                        nvim_lua = "  [Lua]",
                        codeium = "󱎑  [Aic]",
                    })[entry.source.name]
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
                { name = "codeium" },
            }),
        })
    end
}
