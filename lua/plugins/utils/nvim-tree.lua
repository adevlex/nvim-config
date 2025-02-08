return {
	"nvim-tree/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
	},
	config = function()
		require("nvim-tree").setup({
			renderer = {
				root_folder_label = false,
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						default = " ",
						symlink = " ",
						git = {
							deleted = " ",
							unstaged = " ",
							untracked = " ",
							staged = " ",
							unmerged = " ",
						},
					},
					show = {
						git = true,
						folder = true,
						file = true,
						folder_arrow = false,
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						exclude = {
							filetype = {
								"packer",
								"qf",
							},
							buftype = {
								"terminal",
								"help",
							},
						},
					},
				},
			},
			filters = {
				exclude = { ".git", "node_modules", ".cache" },
			},
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
			hijack_directories = { enable = true },
			view = {
				width = 30,
				side = "left",
			},
		})
		vim.cmd([[
        autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
        nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
        ]])
	end,
}
