local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    ["@variable"] = { fg = colors.base09 },
    ["@variable.builtin"] = { fg = colors.base09, bold = true },
    ["@variable.parameter"] = { fg = colors.base08, italic = true },
    ["@variable.member"] = { fg = colors.base08 },
    ["@variable.member.key"] = { fg = colors.base08 },

    ["@module"] = { fg = colors.base08 },
    -- ["@module.builtin"] = { fg = colors.base08 },

    ["@constant"] = { fg = colors.base08, bold = true },
    ["@constant.builtin"] = { fg = colors.base09, bold = true },
    ["@constant.macro"] = { fg = colors.base08, bold = true },

    ["@string"] = { fg = colors.base0B },
    ["@string.regex"] = { fg = colors.base0C },

    ["@string.escape"] = { fg = colors.base0C },
    ["@character"] = { fg = colors.base08 },
    ["@character.special"] = { fg = colors.base08 },
    ["@number"] = { fg = colors.base09 },
    ["@number.float"] = { fg = colors.base09 },

    ["@annotation"] = { fg = colors.base0F },
    ["@attribute"] = { fg = colors.base0A },
    ["@error"] = { fg = colors.base08 },

    ["@keyword.exception"] = { fg = colors.base08 },
    ["@keyword"] = { fg = colors.base0E, italic = true, bold = true },
    ["@keyword.function"] = { fg = colors.base0E },
    ["@keyword.return"] = { fg = colors.base0E },
    ["@keyword.operator"] = { fg = colors.base0E, bold = true },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.conditional"] = { fg = colors.base0E },
    ["@keyword.conditional.ternary"] = { fg = colors.base0E },
    ["@keyword.repeat"] = { fg = colors.base0A },
    ["@keyword.storage"] = { fg = colors.base0A },
    ["@keyword.directive.define"] = { fg = colors.base0E, bold = true },
    ["@keyword.directive"] = { fg = colors.base0A },

    ["@function"] = { fg = colors.base0D, bold = true },
    ["@function.builtin"] = { fg = colors.base0D },
    ["@function.macro"] = { fg = colors.base08, bold = true },
    ["@function.call"] = { fg = colors.base0D, bold = true },
    ["@function.method"] = { fg = colors.base0D, bold = true },
    ["@function.method.call"] = { fg = colors.base0D, bold = true },
    ["@constructor"] = { fg = colors.base0C, bold = true },

    ["@operator"] = { fg = colors.base05 },
    ["@reference"] = { fg = colors.base05 },
    ["@punctuation.bracket"] = { fg = colors.base0F },
    ["@punctuation.delimiter"] = { fg = colors.base0F },
    ["@symbol"] = { fg = colors.base0B },
    ["@tag"] = { fg = colors.base0A },
    ["@tag.attribute"] = { fg = colors.base08, italic = true },
    ["@tag.delimiter"] = { fg = colors.base0F },
    ["@text"] = { fg = colors.base05 },
    ["@text.emphasis"] = { fg = colors.base09, italic = true },
    ["@text.strike"] = { fg = colors.base0F, strikethrough = true },
    ["@type.builtin"] = { fg = colors.base0A },
    ["@definition"] = { sp = colors.base04, underline = true },
    ["@scope"] = { bold = true },
    ["@property"] = { fg = colors.base08 },

    -- markup
    ["@markup.heading"] = { fg = colors.base0D },
    ["@markup.raw"] = { fg = colors.base09 },
    ["@markup.link"] = { fg = colors.base08 },
    ["@markup.link.url"] = { fg = colors.base09, underline = true },
    ["@markup.link.label"] = { fg = colors.base0C },
    ["@markup.list"] = { fg = colors.base08 },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.quote"] = { bg = colors.base00 },

    ["@comment"] = { fg = colors.base05, italic = true },
    ["@comment.todo"] = { fg = colors.base00, bg = colors.base07 },
    ["@comment.warning"] = { fg = colors.base00, bg = colors.base09 },
    ["@comment.note"] = { fg = colors.base00, bg = colors.blue },
    ["@comment.danger"] = { fg = colors.base00, bg = colors.red },

    ["@diff.plus"] = { fg = colors.green },
    ["@diff.minus"] = { fg = colors.red },
    ["@diff.delta"] = { fg = colors.light_grey },

    -- TreesitterContext
    TreesitterContext = { bg = colors.base05, bold = true },
    TreesitterContextBottom = { bold = true },
    TreesitterContextLineNumber = { fg = utils.blend(colors.foreground, colors.background, 0.2), bold = true },

    -- Rainbow Brackets
    RainbowDelimiterRed = { fg = colors.red },
    RainbowDelimiterYellow = { fg = colors.base0A },
    RainbowDelimiterBlue = { fg = colors.blue },
    RainbowDelimiterOrange = { fg = colors.base09 },
    RainbowDelimiterGreen = { fg = colors.green },
    RainbowDelimiterViolet = { fg = colors.base0E },
    RainbowDelimiterCyan = { fg = colors.base0C },

    -- IndentBlankline
    RainbowRed = { fg = colors.red },
    RainbowYellow = { fg = colors.base0A },
    RainbowBlue = { fg = colors.blue },
    RainbowOrange = { fg = colors.base09 },
    RainbowGreen = { fg = colors.green },
    RainbowViolet = { fg = colors.base0E },
    RainbowCyan = { fg = colors.base0C },
}
