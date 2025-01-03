-- Credits to original theme https://github.com/evondev/evondev-dracula
-- This is a modified version

local M = {}

M.main_colors = {
	white = "#F8F8F2",
	darker_black = "#19192c",
	black = "#141423",
	black2 = "#1c1c31",
	one_bg = "#23233d",
	one_bg2 = "#2b2b4c",
	one_bg3 = "#373760",
	grey = "#414171",
	grey_fg = "#4b4b83",
	grey_fg2 = "#555594",
	light_grey = "#6060a4",
	red = "#FF5555",
	baby_pink = "#FF6E6E",
	pink = "#FF6BCB",
	line = "#2D2D4E",
	green = "#50FA7B",
	vibrant_green = "#20E3B2",
	nord_blue = "#05C3FF",
	blue = "#2CCCFF",
	yellow = "#F1FA8C",
	sun = "#F2FA95",
	purple = "#BD93F9",
	dark_purple = "#a166f6",
	teal = "#92A2D4",
	orange = "#FFB86C",
	cyan = "#2CCCFF",
	statusline_bg = "#19192c",
	lightbg = "#2b2b4c",
	pmenu_bg = "#9A86FD",
	folder_bg = "#9A86FD",
	violet = "#9A86FD",
	darkgreen = "#1B312E",
	brownred = "#5D2932",
}

M.base16_palette = {
	base00 = "#141423",
	base01 = M.main_colors.one_bg,
	base02 = M.main_colors.one_bg2,
	base03 = M.main_colors.one_bg3,
	base04 = M.main_colors.grey,
	base05 = "#E9E9F4",
	base06 = "#F1F2F8",
	base07 = "#F7F7FB",
	base08 = "#C197FD",
	base09 = "#FFB86C",
	base0A = "#62D6E8",
	base0B = "#E5C697",
	base0C = "#8BE9FD",
	base0D = "#20E3B2",
	base0E = "#FF6BCB",
	base0F = "#7e7eb5",
}

M.custom_highlights = {
	treesitter = {
		["@function.builtin"] = { fg = M.main_colors.cyan },
		["@number"] = { fg = M.main_colors.purple },
		["@module"] = { fg = M.main_colors.white },
		["@function.call"] = { fg = M.main_colors.vibrant_green },
		["@function"] = { fg = M.main_colors.green },
		["@keyword.repeat"] = { fg = M.main_colors.green },
	},

	syntax = {
		Include = { fg = M.main_colors.pink },
		Error = { fg = M.main_colors.red },
		Identifier = { fg = M.main_colors.white },
		Function = { fg = M.main_colors.vibrant_green },
		String = { fg = M.main_colors.orange },
		Keyword = { fg = M.main_colors.pink },
		Constant = { fg = M.main_colors.violet },
		Type = { fg = M.main_colors.blue },
	},

	git = {
		DiffAdd = { fg = M.main_colors.darkgreen },
		DiffDelete = { fg = M.main_colors.brownred },
	},

	nvimtree = {
		NvimTreeFolderName = { fg = M.main_colors.white },
		NvimTreeOpenedFolderName = { fg = M.main_colors.white, bold = true },
	},
}

M.theme_type = "dark"

M = require("theme").override_theme(M, "chadracula-evondev")

return M
