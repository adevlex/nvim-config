local colors = require("theme").get_theme_tb("main_colors")

local telescope_style = "borderless" -- puedes modificar esto para probar

local hlgroups = {
	TelescopePromptPrefix = {
		fg = colors.red,
		bg = colors.black2,
	},
	TelescopeNormal = { bg = colors.darker_black },
	TelescopePreviewTitle = {
		fg = colors.black,
		bg = colors.green,
	},
	TelescopePromptTitle = {
		fg = colors.black,
		bg = colors.red,
	},
	TelescopeSelection = { bg = colors.black2, fg = colors.white },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.yellow },
	TelescopeResultsDiffDelete = { fg = colors.red },
	TelescopeMatching = { bg = colors.one_bg, fg = colors.blue },
}

local styles = {
	borderless = {
		TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },
		TelescopePromptBorder = { fg = colors.black2, bg = colors.black2 },
		TelescopePromptNormal = { fg = colors.white, bg = colors.black2 },
		TelescopeResultsTitle = { fg = colors.darker_black, bg = colors.darker_black },
		TelescopePromptPrefix = { fg = colors.red, bg = colors.black2 },
	},

	bordered = {
		TelescopeBorder = { fg = colors.one_bg3 },
		TelescopePromptBorder = { fg = colors.one_bg3 },
		TelescopeResultsTitle = { fg = colors.black, bg = colors.green },
		TelescopePreviewTitle = { fg = colors.black, bg = colors.blue },
		TelescopePromptPrefix = { fg = colors.red, bg = colors.black },
		TelescopeNormal = { bg = colors.black },
		TelescopePromptNormal = { bg = colors.black },
	},
}

-- Asegúrate de que telescope_style tenga un valor válido
local selected_style = styles[telescope_style]
if not selected_style then
	-- Si no es válido, puedes usar un estilo predeterminado
	vim.notify("Invalid telescope style: " .. telescope_style, vim.log.levels.WARN)
	selected_style = styles["borderless"] -- Usar el estilo por defecto
end

-- Fusionar los estilos y grupos de resaltado
local result = vim.tbl_deep_extend("force", hlgroups, selected_style)

return result
