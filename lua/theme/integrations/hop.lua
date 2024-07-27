local colors = require("theme").getCurrentTheme()

if not colors then
    return { error = "colors not found" }
end

return {
    HopNextKey = { fg = colors.red, bold = true },
    HopNextKey1 = { fg = colors.green, bold = true },
    HopNextKey2 = { fg = colors.blue, bold = true },
}
