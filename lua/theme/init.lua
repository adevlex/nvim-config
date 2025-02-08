local M = {}
local cache_path = vim.g.themeCache

local function update_config_value(key, value)
	local file_path = vim.fn.stdpath("config") .. "/lua/core/cfg.lua"
	local lines = {}

	local file = io.open(file_path, "r")
	if file then
		for line in file:lines() do
			local updated_line = line:match(key .. "%s*=") and ("  " .. key .. " = " .. tostring(value) .. ",") or line
			table.insert(lines, updated_line)
		end
		file:close()
	end

	file = io.open(file_path, "w")
	if file then
		for _, line in ipairs(lines) do
			file:write(line .. "\n")
		end
		file:close()
	else
		vim.notify("Can't write to file", vim.log.levels.ERROR)
	end
end

M.get_integrations = function()
	local integrations_dir = vim.fn.stdpath("config") .. "/lua/theme/integrations/"
	local files = vim.fn.glob(integrations_dir .. "*.lua", false, true)
	local integrations = {}

	for _, file in ipairs(files) do
		local filename = vim.fn.fnamemodify(file, ":t:r")
		table.insert(integrations, filename)
	end

	return integrations
end

local integrations = M.get_integrations()

M.get_theme_tb = function(type)
	local name = vim.g.nvimTheme
	local present1, default_theme = pcall(require, "theme.schemes." .. name)
	local present2, user_theme = pcall(require, "schemes." .. name)

	if present1 then
		return default_theme[type]
	elseif present2 then
		return user_theme[type]
	else
		error("No such theme!")
	end
end

M.merge_tb = function(...)
	return vim.tbl_deep_extend("force", ...)
end

local lighten = require("theme.colors").change_hex_lightness
local mixcolors = require("theme.colors").mix

-- turns color var names in hl_override/hl_add to actual colors
-- hl_add = { abc = { bg = "one_bg" }} -> bg = colors.one_bg
M.turn_str_to_color = function(tb)
	local colors = M.get_theme_tb("base_30")
	local copy = vim.deepcopy(tb)

	for _, hlgroups in pairs(copy) do
		for opt, val in pairs(hlgroups) do
			local valtype = type(val)

			if opt == "fg" or opt == "bg" or opt == "sp" then
				-- named colors from base30
				if valtype == "string" and val:sub(1, 1) ~= "#" and val ~= "none" and val ~= "NONE" then
					hlgroups[opt] = colors[val]
				elseif valtype == "table" then
					-- transform table to color
					hlgroups[opt] = #val == 2 and lighten(colors[val[1]], val[2])
						or mixcolors(colors[val[1]], colors[val[2]], val[3])
				end
			end
		end
	end

	return copy
end

M.extend_default_hl = function(highlights, integration_name)
	local polish_hl = M.get_theme_tb("polish_hl")

	-- polish themes
	if polish_hl and polish_hl[integration_name] then
		highlights = M.merge_tb(highlights, polish_hl[integration_name])
	end

	-- transparency
	if vim.g.transparency then
		local glassy = require("theme.transparency")

		for key, value in pairs(glassy) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end

	local hl_override = {}
	local overriden_hl = M.turn_str_to_color(hl_override)

	for key, value in pairs(overriden_hl) do
		if highlights[key] then
			highlights[key] = M.merge_tb(highlights[key], value)
		end
	end

	return highlights
end

M.get_integration = function(name)
	local highlights = require("theme.integrations." .. name)
	return M.extend_default_hl(highlights, name)
end

-- convert table into string
M.tb_2str = function(tb)
	local result = ""

	for hlgroupName, v in pairs(tb) do
		local hlname = "'" .. hlgroupName .. "',"
		local hlopts = ""

		for optName, optVal in pairs(v) do
			local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
				or '"' .. optVal .. '"'
			hlopts = hlopts .. optName .. "=" .. valueInStr .. ","
		end

		result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. hlopts .. "})"
	end

	return result
end

M.str_to_cache = function(filename, str)
	local lines = "return string.dump(function()" .. str .. "end, true)"
	local file = io.open(cache_path .. filename, "wb")

	if file then
		---@diagnostic disable-next-line: deprecated
		file:write(loadstring(lines)())
		file:close()
	end
end

M.set_term = function()
	local colors = require("theme").get_theme_tb("base_16")

	local term = {
		"base01",
		"base08",
		"base0B",
		"base0A",
		"base0D",
		"base0E",
		"base0C",
		"base05",
		"base03",
		"base08",
		"base0B",
		"base0A",
		"base0D",
		"base0E",
		"base0C",
		"base07",
	}

	local result = ""

	for i = 0, 15 do
		result = result .. "vim.g.terminal_color_" .. i .. "='" .. colors[term[i + 1]] .. "' "
	end
	return result
end

M.set_color_vars = function()
	local str = ""

	local present1, default_theme = pcall(require, "theme.schemes." .. vim.g.nvimTheme)
	local colors = (present1 and default_theme) or require("schemes." .. vim.g.nvimTheme)

	for name, hex in pairs(colors.base_30) do
		str = str .. name .. "='" .. hex
		str = str .. "',"
	end

	str = "return {" .. str .. "}"

	return str
end

M.compile = function()
	if not vim.uv.fs_stat(vim.g.themeCache) then
		vim.fn.mkdir(cache_path, "p")
	end

	M.str_to_cache("term", M.set_term())
	M.str_to_cache("colors", M.set_color_vars())

	for _, name in ipairs(integrations) do
		local hl_str = M.tb_2str(M.get_integration(name))

		if name == "defaults" then
			hl_str = "vim.o.tgc=true vim.o.bg='" .. M.get_theme_tb("theme_type") .. "' " .. hl_str
		end

		M.str_to_cache(name, hl_str)
	end
end

M.load_all_highlights = function()
	require("plenary.reload").reload_module("theme")
	M.compile()

	for _, name in ipairs(integrations) do
		dofile(vim.g.themeCache .. name)
	end

	-- update blankline
	pcall(function()
		require("ibl").update()
	end)

	vim.api.nvim_exec_autocmds("User", { pattern = "ThemeReload" })
end

M.override_theme = function(default_theme, theme_name)
	local changed_themes = {}
	return M.merge_tb(default_theme, changed_themes.all or {}, changed_themes[theme_name] or {})
end

M.toggle_transparency = function()
	if vim.g.transparency == nil then
		vim.g.transparency = false
	end
	vim.g.transparency = not vim.g.transparency

	update_config_value("transparency", tostring(vim.g.transparency))

	require("theme").load_all_highlights()
	vim.notify("Transparency: " .. tostring(vim.g.transparency), vim.log.levels.INFO)
end

return M
