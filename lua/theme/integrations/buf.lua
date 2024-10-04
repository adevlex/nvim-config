local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    BufflineBufOnActive = { fg = colors.foreground, bg = colors.background },
    BufflineBufOnInactive = { fg = utils.blend(colors.foreground, colors.lighter, 0.45), bg = utils.blend(colors.lighter, colors.foreground, 0.93) },
    BufflineBufOnModified = { fg = colors.base0D, bg = colors.background },
    BuffLineBufOffModified = { fg = colors.base0D, bg = utils.blend(colors.lighter, colors.foreground, 0.93) },
    BufflineBufOnClose = { fg = colors.base08, bg = colors.background },
    BuffLineBufOffClose = { fg = colors.base08, bg = utils.blend(colors.lighter, colors.foreground, 0.93) },

    BuffLineTree = { bg = colors.background, fg = colors.foreground },
    BuffLineEmpty = { bg = colors.background, fg = colors.foreground },
    BuffLineEmptyColor = { bg = colors.lighter, fg = colors.foreground },
    BuffLineButton = { bg = utils.blend(colors.base0E, colors.base00, 0.1), fg = colors.base0E },
    BuffLineCloseButton = { bg = colors.base08, fg = colors.base00 },
    BuffLineRun = { bg = utils.blend(colors.base0F, colors.base00, 0.1), fg = colors.base0F },
    BuffLineSplit = { bg = utils.blend(colors.base0B, colors.base00, 0.1), fg = colors.base0B },
    BufflineTrans = { bg = utils.blend(colors.base0D, colors.base00, 0.1), fg = colors.base0D },
}
