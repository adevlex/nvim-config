local M = {}

M.base_30 = {
	white = "#c9c7cd",
	black = "#161617",
	darker_black = "#18181a",
	black2 = "#1b1b1c",
	one_bg = "#18181a",
	one_bg2 = "#1b1b1c",
	one_bg3 = "#2a2a2c",
	grey = "#6c6874",
	grey_fg = "#8b8693",
	grey_fg2 = "#9f9ca6",
	light_grey = "#b4b1ba",
	red = "#ea83a5",
	baby_pink = "#ed96b3",
	pink = "#e29eca",
	line = "#2a2a2c",
	green = "#90b99f",
	vibrant_green = "#a7c8b3",
	nord_blue = "#a7b3dd",
	blue = "#92a2d5",
	seablue = "#85b5ba",
	yellow = "#e6b99d",
	sun = "#eac5ae",
	purple = "#aca1cf",
	dark_purple = "#b7aed5",
	teal = "#38464e",
	orange = "#f5a191",
	cyan = "#85b5ba",
	statusline_bg = "#18181a",
	lightbg = "#1b1b1c",
	pmenu_bg = "#a7b3dd",
	folder_bg = "#92a2d5",
}

M.base_16 = {
	base00 = "#161617",
	base01 = "#18181a",
	base02 = "#1b1b1c",
	base03 = "#8b8693",
	base04 = "#6c6874",
	base05 = "#c9c7cd",
	base06 = "#b4b1ba",
	base07 = "#c9c7cd",
	base08 = "#ea83a5",
	base09 = "#f5a191",
	base0A = "#e6b99d",
	base0B = "#90b99f",
	base0C = "#85b5ba",
	base0D = "#92a2d5",
	base0E = "#aca1cf",
	base0F = "#e29eca",
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "oldworld")

return M
