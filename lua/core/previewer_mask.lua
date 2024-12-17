local M = {}

local ok, previewers = pcall(require, "telescope.previewers")
if not ok then
	vim.notify("Telescope previewers not found! Make sure telescope is properly installed.", vim.log.levels.ERROR)
	return
end

local sensitive_patterns = {
	"SERVER%s*=%s*%S+",
	"DB%s*=%s*%S+",
	"USERNAME%s*=%s*%S+",
	"PASSWORD%s*=%s*%S+",
	"API_KEY%s*=%s*%S+",
	"SECRET_KEY%s*=%s*%S+",
}

local function mask_sensitive_data(text)
	for _, pattern in ipairs(sensitive_patterns) do
		text = text:gsub(pattern, function(match)
			local key, value = match:match("([^=]+)=(%S+)")
			if key and value then
				return key .. "=" .. string.rep("*", #value)
			else
				return match
			end
		end)
	end
	return text
end

local filetype_map = {
	env = "sh",
	conf = "dosini",
	ini = "dosini",
	yml = "yaml",
	yaml = "yaml",
	json = "json",
	toml = "toml",
	xml = "xml",
	hcl = "hcl",
}

local function detect_filetype(filepath)
	local ext = vim.fn.fnamemodify(filepath, ":e")
	return filetype_map[ext] or ext
end

local function load_and_mask_file(filepath)
	local lines = {}
	local file = io.open(filepath, "r")
	if file then
		for line in file:lines() do
			table.insert(lines, mask_sensitive_data(line))
		end
		file:close()
	else
		table.insert(lines, "Error: Unable to open file.")
	end
	return lines
end

local function masked_previewer(opts)
	return previewers.new_buffer_previewer({
		title = "Masked Previewer",
		define_preview = function(self, entry, status)
			local filepath = entry.path
			local lines = load_and_mask_file(filepath)

			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

			local filetype = detect_filetype(filepath)
			---@diagnostic disable-next-line: deprecated
			vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", filetype)
		end,
	})
end

M.masked_search = function(opts)
	opts = opts or {}
	opts.previewer = masked_previewer(opts)
	require("telescope.builtin").find_files(opts)
end

return M
