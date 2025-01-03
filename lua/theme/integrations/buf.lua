local colors = require("theme").get_theme_tb("main_colors")
local utils = require("theme.colors")

return {
	BufflineBufOnActive = { fg = colors.white, bg = colors.black },
	BufflineBufOnInactive = {
		fg = utils.blend(colors.white, colors.black, 0.45),
		bg = utils.blend(colors.black, colors.white, 0.93),
	},
	BufflineBufOnModified = { fg = colors.blue, bg = colors.black },
	BuffLineBufOffModified = { fg = colors.blue, bg = utils.blend(colors.black, colors.white, 0.93) },
	BufflineBufOnClose = { fg = colors.red, bg = colors.black },
	BuffLineBufOffClose = { fg = colors.red, bg = utils.blend(colors.black, colors.white, 0.93) },

	BuffLineTree = { bg = colors.black, fg = colors.white },
	BuffLineEmpty = { bg = colors.black, fg = colors.white },
	BuffLineEmptyColor = { bg = colors.black, fg = colors.white },
	BuffLineButton = { bg = utils.blend(colors.baby_pink, colors.black, 0.1), fg = colors.baby_pink },
	BuffLineCloseButton = { bg = colors.red, fg = colors.black },
	BuffLineRun = { bg = utils.blend(colors.green, colors.black, 0.1), fg = colors.green },
	BuffLineSplit = { bg = utils.blend(colors.sun, colors.black, 0.1), fg = colors.sun },
	BufflineTrans = { bg = utils.blend(colors.nord_blue, colors.black, 0.1), fg = colors.nord_blue },
}
