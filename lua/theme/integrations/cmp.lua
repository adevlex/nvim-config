local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end
-- Generar background con transparencia usando 'blend'
local function createAlphaBg(foreground, alpha)
    return utils.blend(foreground, colors.background, alpha)
end

-- Mezclar colores usando 'mix'
local function mixColors(c1, c2, weight)
    return utils.mix(c1, c2, weight)
end


return {
    -- Aquí utilizo 'foreground' sólido y 'background' con alpha para el contraste
    CmpItemKindArray = { fg = colors.base0B, bg = createAlphaBg(colors.base0B, 0.2) },
    CmpItemKindBoolean = { fg = colors.base0A, bg = createAlphaBg(colors.base0A, 0.2) },
    CmpItemKindClass = { fg = colors.base0D, bg = createAlphaBg(colors.base0D, 0.2) },
    CmpItemKindColor = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindConstant = { fg = colors.base0C, bg = createAlphaBg(colors.base0C, 0.2) },
    CmpItemKindConstructor = { fg = colors.base05, bg = createAlphaBg(colors.base05, 0.2) },
    CmpItemKindEnum = { fg = colors.base09, bg = createAlphaBg(colors.base09, 0.2) },
    CmpItemKindEnumMember = { fg = colors.base08, bg = createAlphaBg(colors.base08, 0.2) },
    CmpItemKindEvent = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindField = { fg = colors.base09, bg = createAlphaBg(colors.base09, 0.2) },
    CmpItemKindFile = { fg = colors.base0D, bg = createAlphaBg(colors.base0D, 0.2) },
    CmpItemKindFolder = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindFunction = { fg = colors.base0C, bg = createAlphaBg(colors.base0C, 0.2) },
    CmpItemKindInterface = { fg = colors.base0F, bg = createAlphaBg(colors.base0F, 0.2) },
    CmpItemKindKey = { fg = colors.red, bg = createAlphaBg(colors.red, 0.2) },
    CmpItemKindKeyword = { fg = colors.base0B, bg = createAlphaBg(colors.base0B, 0.2) },
    CmpItemKindMethod = { fg = colors.base09, bg = createAlphaBg(colors.base09, 0.2) },
    CmpItemKindModule = { fg = colors.base0D, bg = createAlphaBg(colors.base0D, 0.2) },
    CmpItemKindNamespace = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindNull = { fg = colors.base0C, bg = createAlphaBg(colors.base0C, 0.2) },
    CmpItemKindNumber = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindObject = { fg = colors.base09, bg = createAlphaBg(colors.base09, 0.2) },
    CmpItemKindOperator = { fg = colors.base08, bg = createAlphaBg(colors.base08, 0.2) },
    CmpItemKindPackage = { fg = colors.base0B, bg = createAlphaBg(colors.base0B, 0.2) },
    CmpItemKindProperty = { fg = colors.base0A, bg = createAlphaBg(colors.base0A, 0.2) },
    CmpItemKindReference = { fg = colors.base0D, bg = createAlphaBg(colors.base0D, 0.2) },
    CmpItemKindSnippet = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindString = { fg = colors.base0C, bg = createAlphaBg(colors.base0C, 0.2) },
    CmpItemKindStruct = { fg = colors.base0F, bg = createAlphaBg(colors.base0F, 0.2) },
    CmpItemKindText = { fg = colors.base0F, bg = createAlphaBg(colors.base0F, 0.2) },
    CmpItemKindTypeParameter = { fg = colors.base0B, bg = createAlphaBg(colors.base0B, 0.2) },
    CmpItemKindUnit = { fg = colors.base0A, bg = createAlphaBg(colors.base0A, 0.2) },
    CmpItemKindValue = { fg = colors.base0D, bg = createAlphaBg(colors.base0D, 0.2) },
    CmpItemKindVariable = { fg = colors.base0E, bg = createAlphaBg(colors.base0E, 0.2) },
    CmpItemKindCodeium = { fg = colors.base0B, bg = utils.blend(colors.base0C, colors.darker, 0.4) },
    CmpItemKindSupermaven = { fg = colors.base0B, bg = utils.blend(colors.base0C, colors.darker, 0.4) },

    -- Otros elementos del cmp
    CmpItemAbbr = { fg = colors.foreground },
    CmpItemAbbrDeprecated = { fg = colors.base0B },
    CmpItemAbbrMatch = { fg = colors.base05 },
    CmpItemAbbrMatchFuzzy = { fg = colors.base06 },
    CmpItemKind = { fg = colors.foreground },
    CmpItemMenu = { fg = colors.base0C },
    CmpDoc = { bg = colors.lighter },
    Pmenu = { fg = colors.foreground, bg = colors.darker },
    PmenuSel = { bg = utils.blend(colors.base0D, colors.darker, 0.4) },
    PmenuSbar = { bg = colors.darker },
    PmenuThumb = { bg = colors.base0B },
}
