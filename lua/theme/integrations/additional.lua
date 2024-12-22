local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    Added = { fg = colors.base0B },
    Removed = { fg = colors.base08 },
    Changed = { fg = colors.base0D },
    Normal = { fg = colors.foreground, bg = colors.background },
    NormalFloat = { bg = colors.darker },
    FloatBorder = { fg = colors.darker },
    FloatTitle = { fg = colors.red, bg = colors.background, bold = true },
    WinSeparator = { fg = colors.background },
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },

    WildMenu = { fg = colors.base08, bg = colors.base0A },
    Comment = { fg = colors.base04, italic = true },

    Folded = { fg = utils.blend(colors.foreground, colors.background, 0.3), bg = colors.background },
    FoldColumn = { fg = utils.blend(colors.foreground, colors.background, 0.3), bg = colors.background },

    Cursor = { fg = colors.base00, bg = colors.base05 },
    CursorLine = { bg = utils.blend(colors.foreground, colors.background, 0.02) },
    CursorLineNr = { fg = colors.foreground, bold = true },
    LineNr = { fg = utils.blend(colors.foreground, colors.background, 0.3) },

    CursorColumn = { bg = colors.background },
    ColorColumn = { bg = colors.background },
    SignColumn = { bg = colors.background, fg = colors.background },

    Visual = { bg = colors.base03, fg = colors.foreground },
    VisualNOS = { fg = colors.base08, bg = colors.background },

    ModeMsg = { fg = colors.foreground },
    MsgArea = { fg = colors.foreground, bg = colors.background },
    WarningMsg = { fg = colors.base08 },
    Error = { fg = colors.base00, bg = colors.base08 },
    ErrorMsg = { fg = colors.base08 },
    MoreMsg = { fg = colors.base0B },

    QuickFixLine = { bg = colors.base01, sp = "NONE" },
    MatchWord = { bg = colors.lighter, fg = colors.foreground },
    MatchParen = { link = "MatchWord" },

    Exception = { fg = colors.base08 },
    Macro = { fg = colors.base08 },
    Debug = { fg = colors.base08 },

    Conceal = { bg = "NONE" },
    Directory = { fg = colors.base0D },
    SpecialKey = { fg = colors.base03 },
    Title = { fg = colors.base0D, sp = "NONE" },
    Search = { fg = colors.background, bg = colors.base0A },
    IncSearch = { fg = colors.background, bg = colors.base0A },
    Substitute = { fg = colors.base01, bg = colors.base0A, sp = "NONE" },
    Question = { fg = colors.base0D },
    NonText = { fg = colors.base03 },

    TabLine = { fg = colors.green, bg = colors.background },
    TabLineSel = { fg = colors.foreground, bg = colors.background },
    TabLineFill = { fg = colors.foreground, bg = colors.background },

    SpellBad = { undercurl = true, sp = colors.base08 },
    SpellLocal = { undercurl = true, sp = colors.base0C },
    SpellCap = { undercurl = true, sp = colors.base0D },
    SpellRare = { undercurl = true, sp = colors.base0E },
    healthSuccess = { bg = colors.green, fg = colors.background },

    Bold = { bold = true },
    Italic = { italic = true },
    TooLong = { fg = colors.base08 },
    UnderLined = { underline = true },
}
