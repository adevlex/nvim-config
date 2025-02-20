---NOTE: Cmp configuration

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	config = function()
		local present, cmp = pcall(require, "cmp")
		if not present then
			return
		end

		local kind_icons = {
			Namespace = " ",
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = " ",
			Module = " ",
			Property = " ",
			Unit = " ",
			Number = " ",
			Constant = " ",
			Enum = " ",
			EnumMember = " ",
			Keyword = " ",
			Snippet = " ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
			Table = " ",
			Object = " ",
			Tag = " ",
			Array = " ",
			Boolean = " ",
			Value = " ",
			Null = " ",
			String = " ",
			Calendar = " ",
			Watch = " ",
			Package = " ",
			Copilot = " ",
			Codeium = " ",
			Supermaven = " ",
		}

		cmp.setup({
			snippet = {
				expand = function(args)
					local ok, luasnip = pcall(require, "luasnip")
					if ok then
						luasnip.lsp_expand(args.body)
					end
				end,
			},

			window = {
				completion = {
					border = vim.g.transparency and "rounded" or "solid",
					scrollbar = false,
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					border = vim.g.transparency and "rounded" or "solid",
					scrollbar = false,
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				},
			},

			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<Esc>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					local icons = kind_icons
					local icon = icons[item.kind] or ""
					local kind = item.kind or ""

					item.menu = string.format("%-8s", kind)
					item.menu_hl_group = "CmpItemKind" .. kind
					item.kind = icon

					local api = vim.api
					local cmp_ui = {
						icons_left = false,
						lspkind_text = true,
						format_colors = {
							tailwind = false,
							icon = "󱓻 ",
						},
					}

					local colors_icon = "󱓻 " .. " "

					local format_kk = function(entr, ite)
						local entryItem = entr:get_completion_item()
						local color = entryItem.documentation

						if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
							local hl = "hex-" .. color:sub(2)

							if #api.nvim_get_hl(0, { name = hl }) == 0 then
								api.nvim_set_hl(0, hl, { fg = color })
							end

							ite.kind = cmp_ui.icons_left and colors_icon or " " .. colors_icon
							ite.kind_hl_group = hl
							ite.menu_hl_group = hl
						end
					end

					if cmp_ui.format_colors.tailwind then
						format_kk(entry, item)
					end
					return item
				end,
			},

			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "luasnip_choice" },
				{ name = "snippy" },
				{ name = "nvim_lua" },
				{ name = "vsnip" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "supermaven" },
				{ name = "copilot" },
				{ name = "codeium" },
			}),
		})
	end,
}
