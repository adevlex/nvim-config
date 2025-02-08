local M = {}

M.base_30 = {
	white = "#F5F5F5",
	darker_black = "#0D1117",
	black = "#161B22", -- nvim bg
	black2 = "#1B222A",
	one_bg = "#21262D", -- real bg of GitHub dark
	one_bg2 = "#2A323D",
	one_bg3 = "#323A46",
	grey = "#454D59",
	grey_fg = "#545D6E",
	grey_fg2 = "#636D7E",
	light_grey = "#737F91",
	red = "#FF7B72",
	baby_pink = "#FFA198",
	pink = "#FF82C1",
	line = "#21262D", -- for lines like vertsplit
	green = "#56D364",
	vibrant_green = "#85E89D",
	nord_blue = "#58A6FF",
	blue = "#79C0FF",
	yellow = "#F2CC60",
	sun = "#FFD770",
	purple = "#D2A8FF",
	dark_purple = "#B877DD",
	teal = "#39C5CF",
	orange = "#F0883E",
	cyan = "#76E3EA",
	statusline_bg = "#0D1117",
	lightbg = "#2A323D",
	pmenu_bg = "#56D364",
	folder_bg = "#58A6FF",
	lavender = "#A5D6FF",
}

M.base_16 = {
	base00 = "#161B22",
	base01 = "#21262D",
	base02 = "#2A323D",
	base03 = "#323A46",
	base04 = "#3E4754",
	base05 = "#C9D1D9",
	base06 = "#E6EDF3",
	base07 = "#F5F5F5",
	base08 = "#FF7B72",
	base09 = "#F0883E",
	base0A = "#F2CC60",
	base0B = "#56D364",
	base0C = "#76E3EA",
	base0D = "#58A6FF",
	base0E = "#D2A8FF",
	base0F = "#FF7B72",
}

M.polish_hl = {
	treesitter = {
		["@variable"] = { fg = M.base_30.lavender },
		["@property"] = { fg = M.base_30.teal },
		["@variable.builtin"] = { fg = M.base_30.red },
	},
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "github")

return M
