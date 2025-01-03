local base16 = require("theme").get_theme_tb("base16_palette")
local colors = require("theme").get_theme_tb("main_colors")
local mixcolors = require("theme.colors").mix

local highlights = {
	CmpItemAbbr = { fg = colors.white },
	CmpItemAbbrMatch = { fg = colors.blue, bold = true },
	CmpDoc = { bg = colors.black },
	CmpDocBorder = { fg = colors.one_bg },
	CmpPmenu = { bg = colors.black },
	CmpSel = { link = "PmenuSel", bold = true },
}

local item_kinds = {
	-- cmp item kinds
	CmpItemKindConstant = { fg = base16.base09 },
	CmpItemKindFunction = { fg = base16.base0D },
	CmpItemKindIdentifier = { fg = base16.base08 },
	CmpItemKindField = { fg = base16.base08 },
	CmpItemKindVariable = { fg = base16.base0E },
	CmpItemKindSnippet = { fg = colors.red },
	CmpItemKindText = { fg = base16.base0B },
	CmpItemKindStructure = { fg = base16.base0E },
	CmpItemKindType = { fg = base16.base0A },
	CmpItemKindKeyword = { fg = base16.base07 },
	CmpItemKindMethod = { fg = base16.base0D },
	CmpItemKindConstructor = { fg = colors.blue },
	CmpItemKindFolder = { fg = base16.base07 },
	CmpItemKindModule = { fg = base16.base0A },
	CmpItemKindProperty = { fg = base16.base08 },
	CmpItemKindEnum = { fg = colors.blue },
	CmpItemKindUnit = { fg = base16.base0E },
	CmpItemKindClass = { fg = colors.teal },
	CmpItemKindFile = { fg = base16.base07 },
	CmpItemKindInterface = { fg = colors.green },
	CmpItemKindColor = { fg = colors.white },
	CmpItemKindReference = { fg = base16.base05 },
	CmpItemKindEnumMember = { fg = colors.purple },
	CmpItemKindStruct = { fg = base16.base0E },
	CmpItemKindValue = { fg = colors.cyan },
	CmpItemKindEvent = { fg = colors.yellow },
	CmpItemKindOperator = { fg = base16.base05 },
	CmpItemKindTypeParameter = { fg = base16.base08 },
	CmpItemKindCopilot = { fg = colors.green },
	CmpItemKindCodeium = { fg = colors.vibrant_green },
	CmpItemKindTabNine = { fg = colors.baby_pink },
	CmpItemKindSuperMaven = { fg = colors.yellow },
}

local cmp_ui = {
	icons_left = false, -- only for non-atom styles!
	style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
	format_colors = {
		tailwind = false, -- will work for css lsp too
		icon = "󱓻",
	},
}

-- custom highlights per style!
local styles = {

	default = {
		CmpBorder = { fg = colors.one_bg, bg = colors.one_bg },
	},

	atom = {
		CmpItemMenu = { fg = colors.light_grey, italic = true },
		CmpPmenu = {
			bg = colors.black2,
		},

		CmpDoc = { bg = colors.darker_black },
		CmpDocBorder = { fg = colors.darker_black, bg = colors.darker_black },
	},

	atom_colored = {
		CmpBorder = { fg = colors.darker_black, bg = colors.darker_black },
		CmpItemMenu = { fg = colors.light_grey, italic = true },
		CmpPmenu = {
			bg = colors.darker_black,
		},

		CmpDoc = { bg = colors.darker_black },
		CmpDocBorder = { fg = colors.darker_black, bg = colors.darker_black },
	},

	flat_light = {
		CmpPmenu = {
			bg = colors.black2,
		},

		CmpDoc = { bg = colors.darker_black },
		CmpBorder = { fg = colors.black2, bg = colors.black2 },
		CmpDocBorder = { fg = colors.darker_black, bg = colors.darker_black },
	},

	flat_dark = {
		CmpPmenu = {
			bg = colors.darker_black,
		},

		CmpBorder = { fg = colors.darker_black, bg = colors.darker_black },
		CmpDocBorder = { fg = colors.black2, bg = colors.black2 },
		CmpDoc = { bg = colors.black2 },
	},
}

local generate_color = require("theme.colors").change_hex_lightness

local black2_l = generate_color(colors.black2, 6)
local black2_d = generate_color(colors.black2, -6)

-- override item_kind highlights for atom style
if cmp_ui.style == "atom" then
	for key, value in pairs(item_kinds) do
		item_kinds[key] = vim.tbl_deep_extend("force", value, { bg = vim.o.bg == "dark" and black2_l or black2_d })
	end
end

-- override item_kind highlights for atom_colored style
if cmp_ui.style == "atom_colored" then
	for key, value in pairs(item_kinds) do
		item_kinds[key] = { fg = value.fg, bg = mixcolors(value.fg, colors.black, 70) }
	end
end

highlights = vim.tbl_deep_extend("force", highlights, styles[cmp_ui.style] or {})
highlights = vim.tbl_deep_extend("force", highlights, item_kinds)

return highlights
