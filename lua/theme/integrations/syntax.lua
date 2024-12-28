local colors = require("theme").getDefaultTheme()

if not colors then
  return { error = "colors not found" }
end

return {
  Boolean = { fg = colors.base09, bold = true },
  Character = { fg = colors.base08, italic = true, bold = true },
  Conditional = { fg = colors.base0E },
  Constant = { fg = colors.base08, bold = true },
  Define = { fg = colors.base0E },
  Delimiter = { fg = colors.base0F },
  Float = { fg = colors.base09 },
  Variable = { fg = colors.base05, italic = true },
  Function = { fg = colors.base0D, bold = true },
  Identifier = { fg = colors.base08 },
  Include = { fg = colors.base0D, bold = true },
  Keyword = { fg = colors.base0E, bold = true, italic = true },
  Label = { fg = colors.base0A, bold = true },
  Number = { fg = colors.base09, bold = true },
  Operator = { fg = colors.base05, bold = true },
  PreProc = { fg = colors.base0A, italic = true },
  Repeat = { fg = colors.base0A, bold = true },
  Special = { fg = colors.base0C },
  SpecialChar = { fg = colors.base0F },
  Statement = { fg = colors.base08, bold = true },
  StorageClass = { fg = colors.base0A, bold = true },
  String = { fg = colors.base0B, italic = true },
  Structure = { fg = colors.base0E, bold = true },
  Tag = { fg = colors.base0A, bold = true },
  Todo = { fg = colors.base01, bg = colors.base0A, bold = true },
  Type = { fg = colors.base0A, bold = true },
  Typedef = { fg = colors.base0A, italic = true },
}
