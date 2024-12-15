local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
	return { error = "colors not found" }
end

return {
	LspReferenceText = { fg = colors.darker, bg = colors.foreground },
	LspReferenceRead = { fg = colors.darker, bg = colors.foreground },
	LspReferenceWrite = { fg = colors.darker, bg = colors.foreground },

	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = utils.mix(colors.red, colors.green, 0.5) },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	LspInlayHint = {
		fg = utils.blend(colors.foreground, colors.background, 0.25),
		bg = utils.blend(colors.background, colors.foreground, 0.95),
	},
	LspSignatureActiveParameter = { fg = colors.foreground, bg = colors.blue },

	SymbolUsageText = { fg = utils.blend(colors.foreground, colors.background, 0.25), italic = true },
}
