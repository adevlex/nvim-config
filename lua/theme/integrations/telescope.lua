local colors = require("theme").get_theme_tb("base_30")

return {
	TelescopeNormal = { bg = colors.darker_black },
	TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },

	TelescopePromptBorder = { fg = colors.one_bg2, bg = colors.one_bg2 },
	TelescopePromptNormal = { fg = colors.white, bg = colors.one_bg2 },
	TelescopePromptTitle = { fg = colors.black, bg = colors.red },

	TelescopePreviewTitle = { fg = colors.one_bg2, bg = colors.blue },
	TelescopePreviewBorder = { bg = colors.darker_black, fg = colors.darker_black },

	TelescopeResultsTitle = { fg = colors.one_bg2, bg = colors.green },
	TelescopeResultsBorder = { bg = colors.darker_black, fg = colors.darker_black },

	TelescopeMatching = { bold = true },
	TelescopeSelection = { bg = colors.one_bg2, fg = colors.blue, bold = true },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.blue },
	TelescopeResultsDiffDelete = { fg = colors.red },
}
