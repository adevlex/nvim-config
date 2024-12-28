local M = {}

-- Verifica si un tema está disponible
M.isThemeAvailable = function(themeName)
  return pcall(require, "theme.schemes." .. themeName)
end

-- Obtiene el tema predeterminado
M.getDefaultTheme = function()
  if vim.g.NvimTheme == nil then
    vim.notify("No theme selected", vim.log.levels.WARN)
    return nil
  end

  local defaultThemeAvailable, defaultTheme = M.isThemeAvailable(vim.g.NvimTheme)
  if not defaultThemeAvailable then
    vim.notify("Failed to load default theme", vim.log.levels.ERROR)
    return nil
  end

  return defaultTheme
end

-- Carga la tabla de un tema
M.loadThemeTable = function(themeName)
  return require("theme.integrations." .. themeName)
end

-- Combina tablas de forma profunda
M.mergeTables = function(...)
  return vim.tbl_deep_extend("force", ...)
end

-- Aplica transparencia a los grupos de resaltado
M.applyTransparency = function(highlightGroups)
  if not vim.g.transparency then
    return highlightGroups
  end

  local transparencyTheme = require("theme.transparency")
  for key, transparencyValues in pairs(transparencyTheme) do
    if highlightGroups[key] then
      highlightGroups[key] = M.mergeTables(highlightGroups[key], transparencyValues)
    end
  end

  return highlightGroups
end

-- Convierte un grupo de resaltado en una cadena de configuración
M.highlightGroupToString = function(groupName, groupValues)
  local options = ""
  for optionName, optionValue in pairs(groupValues) do
    local valueStr
    if type(optionValue) == "boolean" then
      valueStr = tostring(optionValue)
    elseif type(optionValue) == "number" then
      valueStr = tostring(optionValue)
    else
      valueStr = '"' .. optionValue .. '"'
    end
    options = options .. optionName .. "=" .. valueStr .. ","
  end
  return "vim.api.nvim_set_hl(0, '" .. groupName .. "', {" .. options .. "})"
end

-- Convierte una tabla de grupos de resaltado en una cadena
M.tableToStr = function(highlightGroups)
  local result = ""
  highlightGroups = M.applyTransparency(highlightGroups)

  for groupName, groupValues in pairs(highlightGroups) do
    result = result .. M.highlightGroupToString(groupName, groupValues)
  end

  return result
end

-- Serializa y guarda una tabla en caché
M.serializeTableToCache = function(fileName, tableData)
  local serializedData = M.tableToStr(tableData)
  local file = io.open(vim.g.themeCache .. fileName, "w")

  if not file then
    vim.notify("Failed to open cache file: " .. fileName, vim.log.levels.ERROR)
    return
  end

  file:write(serializedData)
  file:close()
end

-- Compila todos los temas y los guarda en caché
M.compileThemes = function()
  if not vim.loop.fs_stat(vim.g.themeCache) then
    vim.fn.mkdir(vim.g.themeCache, "p")
  end

  local allThemes = {}
  local themeDir = vim.fn.stdpath("config") .. "/lua/theme/integrations"

  for _, file in ipairs(vim.fn.readdir(themeDir)) do
    local themeName = vim.fn.fnamemodify(file, ":r")
    local themeData = M.loadThemeTable(themeName)

    for key, data in pairs(themeData) do
      allThemes[key] = data
    end
  end

  M.serializeTableToCache("allThemes", allThemes)
end

-- Aplica los colores del esquema de colores al terminal
M.applyTerminalColors = function(colorScheme)
  local colors = {
    "base00", "base01", "base02", "base03", "base04", "base05",
    "base06", "base07", "base08", "base09", "base0A", "base0B",
    "base0C", "base0D", "base0E", "base0F"
  }

  for i, color in ipairs(colors) do
    vim.g["terminal_color_" .. (i - 1)] = colorScheme[color]
  end
end

-- Carga todos los temas desde la caché
M.loadThemes = function()
  M.compileThemes()
  dofile(vim.g.themeCache .. "allThemes")
end

return M
