local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    NoiceMini = { bg = colors.darker, fg = colors.foreground },
    NoiceCmdlinePopup = { bg = colors.darker, fg = colors.foreground },
    NoiceCmdlinePopupBorder = { bg = colors.darker, fg = colors.base04 },
    NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
    NoiceCmdlinePopupTitle = { bg = colors.darker, fg = colors.base0D },
    NoiceLspProgressSpinner = { fg = utils.blend(colors.foreground, colors.background, 0.2) },

    -- Notify
    NotifyBackground = { bg = colors.darker },
    NotifyLogTime = { bg = colors.darker },
    NotifyINFOBorder = { fg = colors.blue, bg = colors.darker },
    NotifyWARNBorder = { fg = colors.base0A, bg = colors.darker },
    NotifyERRORBorder = { fg = colors.red, bg = colors.darker },
    NotifyDEBUGBorder = { fg = colors.base0E, bg = colors.darker },
    NotifyTRACEBorder = { fg = colors.base0C, bg = colors.darker },
    NotifyERRORIcon = { fg = colors.red, bg = colors.darker },
    NotifyWARNIcon = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
    NotifyINFOIcon = { fg = colors.blue, bg = colors.darker },
    NotifyDEBUGIcon = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
    NotifyTRACEIcon = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
    NotifyERRORTitle = { fg = colors.red, bg = colors.darker },
    NotifyWARNTitle = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
    NotifyINFOTitle = { fg = colors.blue, bg = colors.darker },
    NotifyDEBUGTitle = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
    NotifyTRACETitle = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
    NotifyERRORBody = { fg = colors.red, bg = colors.darker },
    NotifyWARNBody = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
    NotifyINFOBody = { fg = colors.blue, bg = colors.darker },
    NotifyDEBUGBody = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
    NotifyTRACEBody = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
}
