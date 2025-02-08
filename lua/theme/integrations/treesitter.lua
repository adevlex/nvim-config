local theme = require("theme").get_theme_tb("base_16")
local base30 = require("theme").get_theme_tb("base_30")

return {

	["@variable"] = { fg = theme.base05 },
	["@variable.builtin"] = { fg = theme.base09, bold = true },
	["@variable.parameter"] = { fg = theme.base08, italic = true },
	["@variable.member"] = { fg = theme.base08 },
	["@variable.member.key"] = { fg = theme.base08 },

	["@module"] = { fg = theme.base08 },
	-- ["@module.builtin"] = { fg = theme.base08 },

	["@constant"] = { fg = theme.base08, bold = true },
	["@constant.builtin"] = { fg = theme.base09, bold = true },
	["@constant.macro"] = { fg = theme.base08, bold = true },

	["@string"] = { fg = theme.base0B },
	["@string.regex"] = { fg = theme.base0C },
	["@string.escape"] = { fg = theme.base0C },
	["@character"] = { fg = theme.base08 },
	-- ["@character.special"] = { fg = theme.base08 },
	["@number"] = { fg = theme.base09 },
	["@number.float"] = { fg = theme.base09 },
	["@boolean"] = { fg = theme.base0A, bold = true },
	["@parameter"] = { fg = theme.base08, italic = true },

	["@annotation"] = { fg = theme.base0F },
	["@attribute"] = { fg = theme.base0A },
	["@error"] = { fg = theme.base08 },

	["@keyword.exception"] = { fg = theme.base08 },
	["@keyword"] = { fg = theme.base0E, italic = true, bold = true },
	["@keyword.function"] = { fg = theme.base0E, italic = true, bold = true },
	["@keyword.return"] = { fg = theme.base0E, italic = true, bold = true },
	["@keyword.operator"] = { fg = theme.base0E, bold = true },
	["@keyword.import"] = { link = "Include" },
	["@keyword.conditional"] = { fg = theme.base0E },
	["@keyword.conditional.ternary"] = { fg = theme.base0E },
	["@keyword.repeat"] = { fg = theme.base0A },
	["@keyword.storage"] = { fg = theme.base0A },
	["@keyword.directive.define"] = { fg = theme.base0E, bold = true },
	["@keyword.directive"] = { fg = theme.base0A },

	["@function"] = { fg = theme.base0D, bold = true },
	["@function.builtin"] = { fg = theme.base0D },
	["@function.macro"] = { fg = theme.base08, bold = true },
	["@function.call"] = { fg = theme.base0D, bold = true },
	["@function.method"] = { fg = theme.base0D, bold = true },
	["@function.method.call"] = { fg = theme.base0D, bold = true },
	["@constructor"] = { fg = theme.base0C, bold = true },

	["@operator"] = { fg = theme.base05 },
	["@reference"] = { fg = theme.base05 },
	["@punctuation.bracket"] = { fg = theme.base0F },
	["@punctuation.delimiter"] = { fg = theme.base0F },
	["@symbol"] = { fg = theme.base0B },
	["@tag"] = { fg = theme.base0A },
	["@tag.attribute"] = { fg = theme.base08, italic = true },
	["@tag.delimiter"] = { fg = theme.base0F },
	["@text"] = { fg = theme.base05 },
	["@text.emphasis"] = { fg = theme.base09, italic = true },
	["@text.strike"] = { fg = theme.base0F, strikethrough = true },
	["@type.builtin"] = { fg = theme.base0A },
	["@definition"] = { sp = theme.base04, underline = true },
	["@scope"] = { bold = true },
	["@property"] = { fg = theme.base08 },

	-- markup
	["@markup.heading"] = { fg = theme.base0D },
	["@markup.raw"] = { fg = theme.base09 },
	["@markup.link"] = { fg = theme.base08 },
	["@markup.link.url"] = { fg = theme.base09, underline = true },
	["@markup.link.label"] = { fg = theme.base0C },
	["@markup.list"] = { fg = theme.base08 },
	["@markup.strong"] = { bold = true },
	["@markup.underline"] = { underline = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.quote"] = { bg = base30.black2 },

	["@comment"] = { fg = base30.grey_fg },
	["@comment.todo"] = { fg = base30.grey, bg = base30.white },
	["@comment.warning"] = { fg = base30.black2, bg = theme.base09 },
	["@comment.note"] = { fg = base30.black, bg = base30.blue },
	["@comment.danger"] = { fg = base30.black2, bg = base30.red },

	["@diff.plus"] = { fg = base30.green },
	["@diff.minus"] = { fg = base30.red },
	["@diff.delta"] = { fg = base30.light_grey },
}
