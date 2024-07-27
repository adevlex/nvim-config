local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    AlphaHeader = { fg = colors.base0D, bg = colors.background },
    AlphaLabel = { fg = colors.base07, bg = colors.background },
    AlphaIcon = { fg = colors.base0D, bold = true },
    AlphaKeyPrefix = { fg = colors.red, bg = utils.blend(colors.red, colors.base00, 0.1) },
    AlphaMessage = { fg = colors.base0D, bg = colors.background },
    AlphaFooter = { fg = colors.base0A, bg = colors.background },
}
