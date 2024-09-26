local colors = require("theme").getCurrentTheme()

if not colors then
    return { error = "colors not found" }
end

return {
    SagaNormal = { bg = colors.darker },
    SagaBorder = { bg = colors.darker, fg = colors.darker },
    RenameNormal = { bg = colors.darker },
    RenameBorder = { bg = colors.darker, fg = colors.darker },

    -- Winbar
    SagaWinbarSep = { fg = colors.foreground },
    SagaWinbarFileName = { fg = colors.foreground },
    SagaWinbarFolderName = { fg = colors.foreground },
    SagaWinbarFolder = { fg = colors.foreground },
}
