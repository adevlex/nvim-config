local M = {}

M.main_colors = {
	white = "#E5E0D3",
	darker_black = "#12171D",
	black = "#161C23", -- nvim bg
	black2 = "#2a2e3b",
	one_bg = "#2a2e3b",
	one_bg2 = "#4a4b50",
	one_bg3 = "#414050",
	grey = "#4a4b50",
	grey_fg = "#414050",
	grey_fg2 = "#4a4b50",
	light_grey = "#CBC6B9",
	red = "#FF3377",
	baby_pink = "#FFA352",
	pink = "#FF5242",
	line = "#2a2e3b", -- for lines like vertsplit
	green = "#AAFF99",
	vibrant_green = "#FFEE99",
	nord_blue = "#00B5D9",
	blue = "#61daf2",
	yellow = "#FFEE99",
	sun = "#FFD9B2",
	purple = "#FF5242",
	dark_purple = "#FF3377",
	teal = "#00B5D9",
	orange = "#FFA352",
	cyan = "#00B5D9",
	statusline_bg = "#000000",
	lightbg = "#2a2e3b",
	pmenu_bg = "#AAFF99",
	folder_bg = "#00B5D9",
}

M.base16_palette = {
	base00 = "#161C23",
	base01 = "#000000",
	base02 = "#2a2e3b",
	base03 = "#4a4b50",
	base04 = "#414050",
	base05 = "#E5E0D3",
	base06 = "#E5E0D3",
	base07 = "#E5E0D3",
	base08 = "#FF3377",
	base09 = "#FFA352",
	base0A = "#FFEE99",
	base0B = "#AAFF99",
	base0C = "#00B5D9",
	base0D = "#61daf2",
	base0E = "#FF5242",
	base0F = "#FFD9B2",
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "guna")

return M
