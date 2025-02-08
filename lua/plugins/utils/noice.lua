return {
	"folke/noice.nvim",
	event = "VeryLazy", -- Load on first UI interaction
	dependencies = {
		"MunifTanjim/nui.nvim", -- UI component library
		"rcarriga/nvim-notify", -- Notification system
	},
	opts = {
		-- Command line configuration
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = { view = "cmdline_input", icon = "󰥻" },
			},
		},

		-- UI views configuration
		views = {
			cmdline_popup = {
				position = { row = "50%", col = "50%" }, -- Centered position
				size = { width = 60, height = "auto" },
				border = { style = "rounded" },
			},
			popup = {
				position = { row = "50%", col = "50%" },
				size = { width = 60, height = 10 },
				border = { style = "rounded" },
			},
		},

		-- Message routing
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "%d fewer lines" },
						{ find = "%d more lines" },
					},
				},
				opts = { skip = true }, -- Skip these messages
			},
		},

		-- LSP integration
		lsp = {
			progress = { enabled = false }, -- Disable LSP progress
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = { enabled = false }, -- Disable hover
			signature = { enabled = false }, -- Disable signature help
			message = { enabled = true, view = "notify" },
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},

		-- Presets
		presets = {
			bottom_search = false,
			command_palette = false,
			long_message_to_split = false,
			inc_rename = false,
			lsp_doc_border = true,
		},

		-- Performance optimizations
		throttle = 1000 / 30, -- 30 FPS
		health = {
			checker = true, -- Run health checks
			interval = 60, -- Check every 60 seconds
		},
	},
	config = function(_, opts)
		local noice = require("noice")
		noice.setup(opts)

		-- Custom key mappings
		vim.keymap.set("n", "<leader>nc", function()
			noice.cmd("close")
		end, { desc = "[N]oice [C]lose" })

		vim.keymap.set("n", "<leader>nh", function()
			noice.cmd("history")
		end, { desc = "[N]oice [H]istory" })

		-- Example: Custom notification
		vim.keymap.set("n", "<leader>nn", function()
			noice.notify("This is a custom notification!", "info", {
				title = "Custom Notification",
				icon = "",
				timeout = 2000,
			})
		end, { desc = "[N]oice [N]otification" })
	end,
}
