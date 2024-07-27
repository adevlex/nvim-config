local M = {}

local function isThemeAvailable(themeName)
    return pcall(require, "theme.schemes." .. themeName)
end

local function getDefaultTheme()
    if vim.g.NvimTheme == nil then
        vim.notify("No theme selected", vim.log.levels.WARN)
        return nil
    end

    local defaultThemeAvailable, defaultTheme = isThemeAvailable(vim.g.NvimTheme)
    if not defaultThemeAvailable then
        vim.notify("Failed to load default theme", vim.log.levels.ERROR)
        return nil
    end

    return defaultTheme
end

local function loadThemeTable(themeName)
    return require("theme.integrations." .. themeName)
end

local function mergeTables(...)
    return vim.tbl_deep_extend("force", ...)
end

local function applyTransparency(highlightGroups)
    if not vim.g.transparency then
        return highlightGroups
    end

    local transparencyTheme = require("theme.transparency")
    for key, transparencyValues in pairs(transparencyTheme) do
        if highlightGroups[key] then
            highlightGroups[key] = mergeTables(highlightGroups[key], transparencyValues)
        end
    end

    return highlightGroups
end

local function highlightGroupToString(groupName, groupValues)
    local options = ""
    for optionName, optionValue in pairs(groupValues) do
        local valueStr = ((type(optionValue)) == "boolean" or type(optionValue) == "number") and tostring(optionValue)
            or '"' .. optionValue .. '"'
        options = options .. optionName .. "=" .. valueStr .. ","
    end
    return "vim.api.nvim_set_hl(0, '" .. groupName .. "', {" .. options .. "})"
end

local function tableToStr(highlightGroups)
    local result = ""
    highlightGroups = applyTransparency(highlightGroups)

    for groupName, groupValues in pairs(highlightGroups) do
        result = result .. highlightGroupToString(groupName, groupValues)
    end

    return result
end

local function serializeTableToCache(fileName, tableData)
    local serializedFunction = "return string.dump(function()" .. tableToStr(tableData) .. "end, true)"
    local file = io.open(vim.g.themeCache .. fileName, "wb")

    if not file then
        vim.notify("Failed to open cache file: " .. fileName, vim.log.levels.ERROR)
        return
    end

    ---@diagnostic disable-next-line: deprecated
    file:write(loadstring(serializedFunction)())
    file:close()
end

local function compileThemes()
    if not vim.loop.fs_stat(vim.g.themeCache) then
        vim.fn.mkdir(vim.g.themeCache, "p")
    end

    local allThemes = {}
    local themeDir = vim.fn.stdpath("config") .. "/lua/theme/integrations"

    for _, file in ipairs(vim.fn.readdir(themeDir)) do
        local themeName = vim.fn.fnamemodify(file, ":r")
        local themeData = loadThemeTable(themeName)

        for key, data in pairs(themeData) do
            allThemes[key] = data
        end
    end

    serializeTableToCache("allThemes", allThemes)
end

local function applyTerminalColors(colorScheme)
    local colors = {
        "base00", "base01", "base02", "base03", "base04", "base05",
        "base06", "base07", "base08", "base09", "base0A", "base0B",
        "base0C", "base0D", "base0E", "base0F"
    }

    for i, color in ipairs(colors) do
        vim.g["terminal_color_" .. (i - 1)] = colorScheme[color]
    end
end

function M.getCurrentTheme()
    return getDefaultTheme()
end

function M.loadThemeTable(themeName)
    return loadThemeTable(themeName)
end

function M.loadThemes()
    compileThemes()
    dofile(vim.g.themeCache .. "allThemes")
end

function M.applyTerminalColors(colorScheme)
    applyTerminalColors(colorScheme)
end

return M
