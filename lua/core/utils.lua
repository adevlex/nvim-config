local M = {}

-- Utilities
local function fileExists(file)
	if not file or file == "" then
		return false
	end
	local lines = vim.fn.readfile(file)
	if not lines then
		vim.notify("Cannot read file: " .. file, vim.log.levels.ERROR)
		return false
	end
	return true, lines
end

function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

-- File Operations
function M.replaceword(middle, old, new, file)
	local exists, lines = fileExists(file)
	if not exists or not lines then
		return
	end

	local new_lines = {}
	local found = false

	for _, line in ipairs(lines) do
		local new_line = line
		if line:find(middle) then
			new_line = middle .. " = " .. (line:find(old) and new or old)
			found = true
		end
		table.insert(new_lines, new_line)
	end

	if not found then
		table.insert(new_lines, middle .. " = " .. new)
	end

	vim.fn.writefile(new_lines, file)
end

-- Color Utilities
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function M.blend(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.mix(c1, c2, wt)
	local r1, g1, b1 = tonumber(c1:sub(2, 3), 16), tonumber(c1:sub(4, 5), 16), tonumber(c1:sub(6, 7), 16)
	local r2, g2, b2 = tonumber(c2:sub(2, 3), 16), tonumber(c2:sub(4, 5), 16), tonumber(c2:sub(6, 7), 16)

	wt = math.min(1, math.max(0, wt))

	local nr = math.floor((1 - wt) * r1 + wt * r2)
	local ng = math.floor((1 - wt) * g1 + wt * g2)
	local nb = math.floor((1 - wt) * b1 + wt * b2)

	return string.format("#%02X%02X%02X", nr, ng, nb)
end

return M
