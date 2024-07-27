local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
    return { error = "colors not found" }
end

return {
    DevIconDefault = { fg = colors.red },
    DevIconC = { fg = colors.blue },
    DevIconCpp = { fg = colors.blue },
    DevIconLua = { fg = colors.blue },
    DevIcondeb = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
    DevIconDockerfile = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
    DevIconHtml = { fg = colors.red },
    DevIconCSS = { fg = colors.blue },
    DevIconJs = { fg = utils.mix(colors.red, colors.green, 0.5) },
    DevIconTs = { fg = colors.blue },
    DevIconTsx = { fg = colors.blue },
    DevIconJsx = { fg = colors.blue },
    DevIconVue = { fg = colors.green },
    DevIconKotlin = { fg = utils.mix(colors.red, colors.blue, 0.5) },
    DevIconJava = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
    DevIconDart = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
    DevIconLock = { fg = colors.red },
    DevIconPng = { fg = utils.mix(colors.red, colors.blue, 0.5) },
    DevIconJpeg = { fg = utils.mix(colors.red, colors.blue, 0.5) },
    DevIconJpg = { fg = utils.mix(colors.red, colors.blue, 0.5) },
    DevIconMp3 = { fg = colors.green },
    DevIconMp4 = { fg = colors.red },
    DevIconPy = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
    DevIconToml = { fg = colors.blue },
    DevIconRb = { fg = colors.red },
    DevIconrpm = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
    DevIconMd = { fg = colors.blue },
    DevIconTrueTypeFont = { fg = colors.foreground },
    DevIconOpenTypeFont = { fg = colors.foreground },
    DevIconxz = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
    DevIconzip = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
    DevIconZig = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
    DevIconSvelte = { fg = colors.red },
    DevIconVim = { fg = colors.green },
    DevIconLicense = { fg = utils.mix(colors.red, colors.green, 0.5) },
    DevIconNix = { fg = colors.blue },
    DevIconGitIgnore = { fg = colors.red },
    DevIconSh = { fg = colors.green },
    DevIconGitlabCI = { fg = colors.red },
}