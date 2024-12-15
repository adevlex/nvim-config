local M = function(style)
    local venv = vim.env.VIRTUAL_ENV

    -- Verifica si hay un entorno virtual activo
    if not venv then
        return "" -- No hay entorno virtual activo
    end

    -- Obtén solo el nombre del entorno virtual
    local venv_name = vim.fn.fnamemodify(venv, ":t") .. " "

    -- Devuelve el formato basado en el estilo solicitado
    if style == "blocks" then
        local name = "%#StalineVenvIcon#" .. " ENV " .. "%#StalineVenvName#" .. " " .. venv_name
        return name .. "%#StalineEmptySpace#" .. " "
    elseif style == "minimal" then
        local name = "%#StalineSep#| %#StalineVenvNameMinimal#" .. venv_name
        return name .. " %#StalineEmptySpaces#" .. " "
    elseif style == "fancy" then
        local name = "%#StalineVenvIcon#" .. "   " .. "%#StalineVenvName#" .. " " .. venv_name .. " "
        return name .. "%#StalineEmptySpace#" .. " "
    else
        return "f" -- Estilo desconocido, no muestra nada
    end
end

return M
