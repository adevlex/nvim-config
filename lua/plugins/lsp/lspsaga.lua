return {
	"nvimdev/lspsaga.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	event = "LspAttach",
	keys = function()
		local mappings = {
			--{ "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Doc" },
			{ "<leader>e", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" },
			{ "<leader>a", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
			{ "<leader>o", "<cmd>Lspsaga outline<cr>", desc = "Open Outline" },
			{ "<leader>I", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming Calls" },
			{ "<leader>O", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing Calls" },
			{ "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
		}
		for _, keymap in ipairs(mappings) do
			vim.api.nvim_set_keymap("n", keymap[1], keymap[2], { noremap = true, silent = true, desc = keymap.desc })
		end
	end,
	config = function()
		local saga = require("lspsaga")
		saga.setup({
			lightbulb = {
				enable = true,
				enable_in_insert = true,
				sign = false,
				sign_priority = 40,
				virtual_text = true,
			},
			symbol_in_winbar = {
				enable = true,
				separator = "  ",
				ignore_patterns = {},
				hide_keyword = true,
				show_file = true,
				folder_level = 1,
				respect_root = false,
				color_mode = true,
			},
			ui = {
				theme = "border",
				border = "solid",
				winblend = 0,
				expand = "",
				collaspe = "",
				preview = " ",
				code_action = "󱧣 ",
				diagnostic = "🐞",
				hover = " ",
				kind = {},
			},
		})
	end,
}
