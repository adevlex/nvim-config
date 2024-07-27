return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local dashboard = require("alpha.themes.dashboard")

        -- helper function for utf8 chars
        local function getCharLen(s, pos)
            local byte = string.byte(s, pos)
            if not byte then
                return nil
            end
            return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
        end

        local function applyColors(logo, colors, logoColors)
            dashboard.section.header.val = logo

            for key, color in pairs(colors) do
                local name = "Alpha" .. key
                vim.api.nvim_set_hl(0, name, color)
                colors[key] = name
            end

            dashboard.section.header.opts.hl = {}
            for i, line in ipairs(logoColors) do
                local highlights = {}
                local pos = 0

                for j = 1, #line do
                    local opos = pos
                    pos = pos + getCharLen(logo[i], opos + 1)

                    local color_name = colors[line:sub(j, j)]
                    if color_name then
                        table.insert(highlights, { color_name, opos, pos })
                    end
                end

                table.insert(dashboard.section.header.opts.hl, highlights)
            end
            return dashboard.opts
        end

        local plugins_count = require("lazy").stats().count

        local function MakeButton(label, shortcut, hl_label, hl_icon)
            return {
                type = "button",
                on_press = function()
                    local key = vim.api.nvim_replace_termcodes(shortcut:gsub("%s", ""):gsub("LDR", "<leader>"), true,
                        false, true)
                    vim.api.nvim_feedkeys(key, "normal", false)
                end,
                val = " " .. label .. " ",
                opts = {
                    position = "center",
                    shortcut = " " .. shortcut .. " ",
                    cursor = 5,
                    width = 45,
                    align_shortcut = "right",
                    hl_shortcut = "AlphaKeyPrefix",
                    hl = {
                        { hl_icon,  0, 6 },
                        { hl_label, 6, 30 },
                    },
                },
            }
        end

        local buttons = {
            { "   Find File", "LDR f f" },
            { "󰈚   Recent Files", "LDR f r" },
            { "󰈭   Find Word", "LDR f w" },
            { "   New File", "LDR f n" },
        }

        local message = "[ ━━━━━━ ❖  ━━━━━━ ]"
        local footer = "󰮯      Plugins Instalados: " .. plugins_count

        require("alpha").setup(applyColors({
            [[  ███       ███  ]],
            [[  ████      ████ ]],
            [[  ████     █████ ]],
            [[ █ ████    █████ ]],
            [[ ██ ████   █████ ]],
            [[ ███ ████  █████ ]],
            [[ ████ ████ ████ ]],
            [[ █████  ████████ ]],
            [[ █████   ███████ ]],
            [[ █████    ██████ ]],
            [[ █████     █████ ]],
            [[ ████      ████ ]],
            [[  ███       ███  ]],
            [[                    ]],
            [[  N  E  O  V  I  M  ]],
        }, {
            ["b"] = { fg = "#3399ff", ctermfg = 33 },
            ["a"] = { fg = "#53C670", ctermfg = 35 },
            ["g"] = { fg = "#39ac56", ctermfg = 29 },
            ["h"] = { fg = "#33994d", ctermfg = 23 },
            ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
            ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
            ["k"] = { fg = "#30A572", ctermfg = 36 },
        }, {
            [[  kkkka       gggg  ]],
            [[  kkkkaa      ggggg ]],
            [[ b kkkaaa     ggggg ]],
            [[ bb kkaaaa    ggggg ]],
            [[ bbb kaaaaa   ggggg ]],
            [[ bbbb aaaaaa  ggggg ]],
            [[ bbbbb aaaaaa igggg ]],
            [[ bbbbb  aaaaaahiggg ]],
            [[ bbbbb   aaaaajhigg ]],
            [[ bbbbb    aaaaajhig ]],
            [[ bbbbb     aaaaajhi ]],
            [[ bbbbb      aaaaajh ]],
            [[  bbbb       aaaaa  ]],
            [[                    ]],
            [[  a  a  a  b  b  b  ]],
        }))

        dashboard.section.buttons.val = {}
        for _, j in ipairs(buttons) do
            local btn = MakeButton(j[1], j[2], "AlphaLabel", "AlphaIcon")
            table.insert(dashboard.section.buttons.val, btn)
        end

        local heading = {
            type = "text",
            val = message,
            opts = {
                position = "center",
                hl = "AlphaMessage",
            },
        }

        dashboard.section.footer.val = footer
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.config.opts.noautocmd = true

        local opts = {
            layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 1 },
                heading,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer,
            },
            opts = {
                margin = 5
            },
        }

        require("alpha").setup(opts)
    end,
}
