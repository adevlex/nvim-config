local previewers = require("telescope.previewers")
local string_replace = function(text)
	local patterns = {
		["SERVER%s*=%s*%S+"] = "SERVER=********",
		["DB%s*=%s*%S+"] = "DB=********",
		["USERNAME%s*=%s*%S+"] = "USERNAME=********",
		["PASSWORD%s*=%s*%S+"] = "PASSWORD=********",
		["API_KEY%s*=%s*%S+"] = "API_KEY=********",
		["SECRET_KEY%s*=%s*%S+"] = "SECRET_KEY=********",
	}

	for pattern, replacement in pairs(patterns) do
		text = text:gsub(pattern, replacement)
	end
	return text
end

local masked_previewer = function(opts)
	return previewers.new_buffer_previewer({
		title = "Masked Previewer",
		define_preview = function(self, entry, status)
			local lines = {}
			local filetype = vim.fn.fnamemodify(entry.path, ":e") -- Detectar extensión del archivo
			local ft_map = { env = "sh", conf = "dosini", lua = "lua", json = "json" } -- Mapeo de filetypes

			local file = io.open(entry.path, "r")
			if file then
				for line in file:lines() do
					table.insert(lines, string_replace(line))
				end
				file:close()
			end
			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

			-- Asignar filetype para activar Treesitter
			local detected_ft = ft_map[filetype] or filetype
			---@diagnostic disable-next-line: deprecated
			vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", detected_ft)
		end,
	})
end

return function(opts)
	opts = opts or {}
	opts.previewer = masked_previewer(opts)
	require("telescope.builtin").find_files(opts)
end
