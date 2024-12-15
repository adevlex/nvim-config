local colors = require("theme").getCurrentTheme()

if not colors then
	return { error = "colors not found" }
end

return {
	CodeActionMenuWarningMessageText = { fg = colors.base05 },
	CodeActionMenuWarningMessageBorder = { fg = colors.base08 },
	CodeActionMenuMenuIndex = { fg = colors.base0E },
	CodeActionMenuMenuKind = { fg = colors.base0A },
	CodeActionMenuMenuTitle = { fg = colors.base05 },
	CodeActionMenuMenuDisabled = { link = "Comment" },
	CodeActionMenuMenuSelection = { fg = colors.base0E },
	CodeActionMenuDetailsTitle = { fg = colors.base05 },
	CodeActionMenuDetailsLabel = { fg = colors.base0B },
	CodeActionMenuDetailsPreferred = { fg = colors.base0D },
	CodeActionMenuDetailsDisabled = { link = "Comment" },
	CodeActionMenuDetailsUndefined = { link = "Comment" },
}
