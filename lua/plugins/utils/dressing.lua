return {
	"stevearc/dressing.nvim",
	opts = {
		border = vim.g.transparency and "rounded" or "solid",
		input = {
			enabled = true,
			border = vim.g.transparency and "rounded" or "solid",
			default_prompt = "Input:",
			title_pos = "center",
		},
		win_options = {
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,Title:Title",
		},
	},
}
