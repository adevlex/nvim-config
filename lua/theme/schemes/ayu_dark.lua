-- credits to original theme https://github.com/ayu-theme/ayu-vim (dark)
-- This is just a modified version of it

local M = {}

M.main_colors = {
	white = "#ced4df",
	darker_black = "#05080e",
	black = "#0B0E14", --  nvim bg
	black2 = "#14171d",
	one_bg = "#1c1f25",
	one_bg2 = "#24272d",
	one_bg3 = "#2b2e34",
	grey = "#33363c",
	grey_fg = "#3d4046",
	grey_fg2 = "#46494f",
	light_grey = "#54575d",
	red = "#F07178",
	baby_pink = "#ff949b",
	pink = "#ff8087",
	line = "#24272d", -- for lines like vertsplit
	green = "#AAD84C",
	vibrant_green = "#b9e75b",
	blue = "#36A3D9",
	nord_blue = "#43b0e6",
	yellow = "#E7C547",
	sun = "#f0df8a",
	purple = "#c79bf4",
	dark_purple = "#A37ACC",
	teal = "#74c5aa",
	orange = "#ffa455",
	cyan = "#95E6CB",
	statusline_bg = "#12151b",
	lightbg = "#24272d",
	pmenu_bg = "#ff9445",
	folder_bg = "#98a3af",
}

M.base16_palette = {
	base00 = "#0B0E14",
	base01 = "#1c1f25",
	base02 = "#24272d",
	base03 = "#2b2e34",
	base04 = "#33363c",
	base05 = "#c9c7be",
	base06 = "#E6E1CF",
	base07 = "#D9D7CE",
	base08 = "#c9c7be",
	base09 = "#FFEE99",
	base0A = "#56c3f9",
	base0B = "#AAD84C",
	base0C = "#FFB454",
	base0D = "#F07174",
	base0E = "#FFB454",
	base0F = "#CBA6F7",
}

M.custom_highlights = {
	treesitter = {
		luaTSField = { fg = M.base16_palette.base0D },
		["@tag.delimiter"] = { fg = M.main_colors.cyan },
		["@function"] = { fg = M.main_colors.orange },
		["@variable.parameter"] = { fg = M.base16_palette.base0F },
		["@constructor"] = { fg = M.base16_palette.base0A },
		["@tag.attribute"] = { fg = M.main_colors.orange },
	},
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "ayu_dark")

return M
