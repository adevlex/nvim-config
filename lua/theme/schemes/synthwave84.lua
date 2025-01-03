local M = {}

M.main_colors = {
	white = "#e5e5e5",
	darker_black = "#1e1828",
	black = "#2a2139", -- nvim bg
	black2 = "#3c2d4a",
	one_bg = "#3c2d4a",
	one_bg2 = "#676e95",
	one_bg3 = "#8796b0",
	grey = "#676e95",
	grey_fg = "#8796b0",
	grey_fg2 = "#ffefae",
	light_grey = "#8796b0",
	red = "#ff5370",
	baby_pink = "#ff7edb",
	pink = "#fe4450",
	line = "#3c2d4a", -- for lines like vertsplit
	green = "#c3e88d",
	vibrant_green = "#72f1b8",
	nord_blue = "#82aaff",
	blue = "#abf3fd",
	yellow = "#f78c6c",
	sun = "#ffefae",
	purple = "#ff7edb",
	dark_purple = "#fe4450",
	teal = "#72f1b8",
	orange = "#f78c6c",
	cyan = "#72f1b8",
	statusline_bg = "#1e1828",
	lightbg = "#3c2d4a",
	pmenu_bg = "#c3e88d",
	folder_bg = "#82aaff",
}

M.base16_palette = {
	base00 = "#2a2139",
	base01 = "#1e1828",
	base02 = "#3c2d4a",
	base03 = "#676e95",
	base04 = "#8796b0",
	base05 = "#ffefae",
	base06 = "#ffffff",
	base07 = "#ffffff",
	base08 = "#fe4450",
	base09 = "#ff7edb",
	base0A = "#72f1b8",
	base0B = "#f78c6c",
	base0C = "#72f1b8",
	base0D = "#abf3fd",
	base0E = "#ffefae",
	base0F = "#72f1b8",
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "synthwave84")

return M
