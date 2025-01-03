local function clone_lazy_nvim_repo()
	local lazy_plugin_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if vim.loop.fs_stat(lazy_plugin_path) then
		return
	end

	local git_clone_cmd = { "git", "clone", "https://github.com/folke/lazy.nvim.git", lazy_plugin_path }
	local result = vim.fn.system(git_clone_cmd)

	if vim.v.shell_error ~= 0 then
		error("Error al clonar el repositorio lazy.nvim: " .. result)
	end
end

function Bootstrap()
	clone_lazy_nvim_repo()

	local lazy_plugin_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	vim.opt.rtp:prepend(lazy_plugin_path)
end

function Setup()
	local status_ok, lazy = pcall(require, "lazy")

	if not status_ok then
		error("No se pudo cargar el módulo 'lazy'")
	end

	lazy.setup({
		spec = {
			{ import = "plugins.lsp" },
			{ import = "plugins.comment" },
			{ import = "plugins.dap" },
			{ import = "plugins.git" },
			{ import = "plugins.ia" },
			{ import = "plugins.ts" },
			{ import = "plugins.utils" },
			{ import = "plugins.learn" },
		},
	})
end

Bootstrap()
Setup()
