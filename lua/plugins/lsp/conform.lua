---NOTE: Conform Prettier

return {
	"stevearc/conform.nvim",
	event = "BufWritePre", -- uncomment for format on save
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			c_sharp = { "csharpier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			markdown_inline = { "prettier" },
			typescript = { "prettier" },
			java = { "prettier" },
			rust = { "rustfmt" },
			proto = { "prettier" },
			python = { "black" },
			latex = { "latexindent" },
			cpp = { "clang-format" },
			c = { "clang-format" },
		},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
