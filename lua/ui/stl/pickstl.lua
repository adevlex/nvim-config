local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local config = require("telescope.config").values

local M = {}

local styles = { "fancy", "blocks", "minimal" }

local function update_config_value(key, value)
	local file_path = vim.fn.stdpath("config") .. "/lua/core/cfg.lua"
	local lines = {}

	-- Leer el archivo línea por línea
	local file = io.open(file_path, "r")
	if file then
		for line in file:lines() do
			-- Buscar la clave y reemplazar su valor
			local updated_line = line:match(key .. "%s*=") and ("  " .. key .. " = '" .. value .. "',") or line
			table.insert(lines, updated_line)
		end
		file:close()
	end

	-- Escribir los cambios en el archivo
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

local function set_status_style(style)
	if not style or style == "" then
		vim.notify("Invalid status style", vim.log.levels.ERROR)
		return
	end

	vim.g.statusStyle = style
	update_config_value("statusStyle", style)

	-- Retrasar un poco la ejecución para evitar que se pase `nil`
	vim.defer_fn(function()
		local valid_style = vim.g.statusStyle or "fancy"
		require("ui.stl").setup(valid_style)
		vim.notify("Statusline style: " .. valid_style, vim.log.levels.INFO)
	end, 50) -- Espera 50ms antes de ejecutar setup
end

function M.select_status_style()
	pickers
		.new({}, {
			prompt_title = "󱑞  Statusline Style",
			layout_config = { height = 0.40, width = 0.40 },
			finder = finders.new_table({ results = styles }),
			sorter = config.generic_sorter(),
			attach_mappings = function(bufnr, map)
				map("i", "<CR>", function()
					local selected = action_state.get_selected_entry()
					if selected then
						set_status_style(selected[1])
						actions.close(bufnr)
					end
				end)
				return true
			end,
		})
		:find()
end

return M
