-- ===========================================
-- Autocommands y Utilidades Personalizadas
-- ===========================================

-- Grupo de autocomandos
local custom_autocmd_group = vim.api.nvim_create_augroup("CustomAutocmdGroup", { clear = true })

-- ================================
-- Utilidades
-- ================================

--- Verifica si la ruta es un directorio
---@param path string
---@return boolean
local function is_directory(path)
	return vim.fn.isdirectory(path) == 1
end

--- Determina si debe omitirse la pantalla de inicio (Alpha)
---@return boolean
local function should_skip_alpha()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
		return true
	end

	for _, arg in ipairs(vim.v.argv) do
		if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
			return true
		end
	end

	return false
end

--- Recarga la configuración de Neovim al guardar un archivo .lua
local function reload_neovim_config()
	local fp = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
	local app_name = vim.env.NVIM_APPNAME or "nvim"
	local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
	vim.cmd("silent source %")
	if vim.g.loadNvimTheme then
		require("plenary.reload").reload_module("theme")
	end
	require("plenary.reload").reload_module(module)
	if vim.g.loadNvimTheme then
		require("theme").loadThemes()
	end
end

-- Autocomandos
-- ================================

-- Autocomando para cargar el tema al iniciar
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		if vim.g.loadNvimTheme then
			local themeFile = vim.g.themeCache .. "allThemes"
			if vim.fn.filereadable(themeFile) == 1 then
				dofile(themeFile)
			else
				vim.notify("El archivo " .. themeFile .. " no existe", vim.log.levels.ERROR)
			end
		end

		if should_skip_alpha() then
			return
		end

		vim.cmd("Alpha")
	end,
	desc = "Cargar Alpha en UIEnter",
})

-- Abrir nvim-tree en directorios
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		if is_directory(data.file) then
			vim.cmd.cd(data.file)
			require("nvim-tree.api").tree.open()
		end
	end,
	desc = "Abrir nvim-tree al entrar en un directorio",
})

-- Mostrar ventana flotante de diagnósticos al mantener el cursor
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
	end,
	desc = "Mostrar diagnósticos de LSP al mantener el cursor",
})

-- Resaltar texto copiado
vim.api.nvim_create_autocmd("TextYankPost", {
	group = custom_autocmd_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Resaltar texto copiado",
})

-- Cerrar ventanas específicas con la tecla 'q'
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = custom_autocmd_group,
	callback = function()
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close<cr>", { silent = true, noremap = true })
		end
	end,
	desc = "Cerrar ventanas de ayuda, quickfix, etc. con 'q'",
})

-- Configurar buffer quickfix para que no sea listado
vim.api.nvim_create_autocmd("FileType", {
	group = custom_autocmd_group,
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "No listar el buffer quickfix",
})

-- Recargar configuración de Neovim al guardar archivos .lua
vim.api.nvim_create_autocmd("BufWritePost", {
	group = custom_autocmd_group,
	pattern = vim.fn.stdpath("config") .. "/lua/*.lua",
	callback = reload_neovim_config,
	desc = "Recargar configuración al guardar archivos .lua",
})

-- Desactivar números en terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
	desc = "Desactivar números en buffers de terminal",
})

-- ================================
-- Comandos personalizados
-- ================================

vim.api.nvim_create_user_command("NvimTheme", function()
	require("theme.pick").setup()
end, { desc = "Abrir selector de temas" })

vim.api.nvim_create_user_command("NvimToggleTrans", function()
	require("theme.pick").toggleTransparency()
end, { desc = "Alternar transparencia del tema" })

vim.api.nvim_create_user_command("Ranger", function()
	require("core.functions").ranger_toggle()
end, { desc = "Abrir/Alternar Ranger" })
