local telescope = {
	pickers = require("telescope.pickers"),
	finders = require("telescope.finders"),
	actions = require("telescope.actions"),
	action_state = require("telescope.actions.state"),
	config = require("telescope.config").values,
}

local M = {}

local function update_theme_in_file(theme)
	local file_path = vim.fn.stdpath("config") .. "/lua/core/cfg.lua"
	local lines = {}

	-- Leer el archivo línea por línea
	local file = io.open(file_path, "r")
	if file then
		for line in file:lines() do
			-- Si encuentra la línea del tema, la reemplaza
			local updated_line = line:match("theme%s*=") and ("  theme = '" .. theme .. "',") or line
			table.insert(lines, updated_line)
		end
		file:close()
	end

	-- Escribir las líneas modificadas de vuelta al archivo
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

function M.is_available(plugin)
	local ok, lazy_config = pcall(require, "lazy.core.config")
	return ok and lazy_config.spec.plugins[plugin] ~= nil
end

local themes = (function()
	local theme_files = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/theme/schemes")
	local theme_names = {}
	for _, file in ipairs(theme_files) do
		table.insert(theme_names, vim.fn.fnamemodify(file, ":r"))
	end
	table.sort(theme_names)
	return theme_names
end)()

local function reload_theme_module()
	package.loaded["theme"] = nil
	require("theme").load_all_highlights()
end

local function set_theme(theme)
	if theme then
		vim.g.nvimTheme = theme
		update_theme_in_file(theme)
		reload_theme_module()
	end
end

local function handle_text_changed()
	local selected = telescope.action_state.get_selected_entry()
	if selected then
		set_theme(selected[1])
	end
end

local function map_telescope_actions(bufnr, map)
	map("i", "<CR>", function()
		local selected = telescope.action_state.get_selected_entry()
		if selected then
			set_theme(selected[1])
			telescope.actions.close(bufnr)
		end
	end)

	local function move_selection(next)
		if next then
			telescope.actions.move_selection_next(bufnr)
		else
			telescope.actions.move_selection_previous(bufnr)
		end
		handle_text_changed()
	end

	map("i", "<Down>", function()
		move_selection(true)
	end)
	map("i", "<C-j>", function()
		move_selection(true)
	end)
	map("i", "<Up>", function()
		move_selection(false)
	end)
	map("i", "<C-k>", function()
		move_selection(false)
	end)
end

local function create_autocmd(bufnr)
	vim.schedule(function()
		vim.api.nvim_create_autocmd("TextChangedI", {
			buffer = bufnr,
			callback = handle_text_changed,
		})
	end)
end

function M.setup()
	telescope.pickers
		.new({}, {
			prompt_title = "  Colorschemes",
			layout_config = { height = 0.50, width = 0.50 },
			finder = telescope.finders.new_table({ results = themes }),
			sorter = telescope.config.generic_sorter(),
			attach_mappings = function(bufnr, map)
				create_autocmd(bufnr)
				map_telescope_actions(bufnr, map)
				return true
			end,
		})
		:find()
end

function M.toggle_transparency()
	vim.g.transparency = not vim.g.transparency
	reload_theme_module()
end

function M.random()
	local random_theme = themes[math.random(#themes)]
	set_theme(random_theme)
end

return M
