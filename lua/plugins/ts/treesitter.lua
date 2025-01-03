return {
	"nvim-treesitter/nvim-treesitter",
	run = "TSUpdate",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "python", "javascript", "lua" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
