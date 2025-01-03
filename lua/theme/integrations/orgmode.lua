local colors = require("theme").get_theme_tb("main_colors")

return {
	["@org.headline.level1.org"] = { fg = colors.red },
	["@org.headline.level2.org"] = { fg = colors.orange },
	["@org.headline.level3.org"] = { fg = colors.yellow },
	["@org.headline.level4.org"] = { fg = colors.green },
	["@org.headline.level5.org"] = { fg = colors.blue },
	["@org.headline.level6.org"] = { fg = colors.purple },
}
