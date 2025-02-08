local colors = require("theme").get_theme_tb("base_30")
local utils = require("theme.colors")

return {
	AlphaHeader = { fg = colors.baby_pink },
	AlphaLabel = { fg = colors.yellow, bg = colors.black },
	AlphaIcon = { fg = colors.nord_blue, bg = colors.black },
	AlphaKeyPrefix = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1) },
	AlphaMessage = { fg = colors.purple, bg = colors.black },
	AlphaFooter = { fg = colors.sun, bg = colors.black },
}
