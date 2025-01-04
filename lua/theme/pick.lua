local M = {}
local api = vim.api
local volt = require("volt")
local ui = require("theme.ui")
local state = require("theme.state")
local colors = require("theme.colors")

state.ns = api.nvim_create_namespace("Themes")

M.list_themes = function()
	local default_themes = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/theme/schemes/") or {}

	for index, theme in ipairs(default_themes) do
		default_themes[index] = theme:match("(.+)%..+")
	end

	return default_themes
end

if not state.val then
	state.val = M.list_themes()
	state.themes_shown = state.val
end

local gen_word_pad = function()
	local largest = 0

	for i = state.index, math.min(state.index + state.limit[state.style], #state.val), 1 do
		local namelen = #state.val[i]
		if namelen > largest then
			largest = namelen
		end
	end

	state.longest_name = largest
end

M.open = function(opts)
	opts = opts or {}
	state.buf = api.nvim_create_buf(false, true)
	state.input_buf = api.nvim_create_buf(false, true)

	state.style = opts.style or "bordered"

	local style = state.style

	state.icons.user = opts.icon
	state.icon = state.icons.user or state.icons[style]

	gen_word_pad()

	state.w = state.longest_name + state.word_gap + (#state.order * api.nvim_strwidth(state.icon)) + (state.xpad * 2)

	if style == "compact" then
		state.w = state.w + 4 -- 1 x 2 padding on left/right + 2 of scrollbar
	end

	if style == "flat" then
		state.w = state.w + 8
	end

	volt.gen_data({
		{
			buf = state.buf,
			layout = { { name = "themes", lines = ui[state.style] } },
			xpad = state.xpad,
			ns = state.ns,
		},
	})

	local h = state.limit[style] + 1

	if style == "flat" or style == "bordered" then
		local step = state.scroll_step[state.style]
		h = (h * step) - 5
	end

	local input_win_opts = {
		row = math.floor((vim.o.lines - h) / 2),
		col = math.floor((vim.o.columns - state.w) / 2),
		width = state.w,
		height = 1,
		relative = "editor",
		style = "minimal",
		border = "single",
	}

	if style == "flat" or style == "bordered" then
		input_win_opts.row = input_win_opts.row - 2
	end

	state.input_win = api.nvim_open_win(state.input_buf, true, input_win_opts)

	state.win = api.nvim_open_win(state.buf, false, {
		row = 2,
		col = -1,
		width = state.w,
		height = ((style == "flat" or style == "bordered") and h + 2) or h,
		relative = "win",
		style = "minimal",
		border = "single",
	})

	vim.bo[state.input_buf].buftype = "prompt"
	vim.fn.prompt_setprompt(state.input_buf, state.prompt)
	vim.cmd("startinsert")

	if opts.border then
		api.nvim_set_hl(state.ns, "FloatBorder", { link = "Comment" })
		api.nvim_set_hl(state.ns, "Normal", { link = "Normal" })
		vim.wo[state.input_win].winhl = "Normal:Normal"
	else
		vim.wo[state.input_win].winhl = "Normal:ExBlack2Bg,FloatBorder:ExBlack2Border"
		api.nvim_set_hl(state.ns, "Normal", { link = "ExDarkBg" })
		api.nvim_set_hl(state.ns, "FloatBorder", { link = "ExDarkBorder" })
	end

	api.nvim_set_hl(state.ns, "NScrollbarOff", { fg = colors.one_bg2 })
	api.nvim_win_set_hl_ns(state.win, state.ns)
	api.nvim_set_current_win(state.input_win)

	local volt_opts = { h = #state.val, w = state.w }

	if state.style == "flat" or state.style == "bordered" then
		local step = state.scroll_step[state.style]
		volt_opts.h = (volt_opts.h * step) + 2
	end

	volt.run(state.buf, volt_opts)

	----------------- keymaps --------------------------
	volt.mappings({
		bufs = { state.buf, state.input_buf },
		after_close = function()
			if not state.confirmed then
				require("plenary.reload").reload_module("theme")
				local theme = vim.g.nvimTheme
				require("theme.utils").reload_theme(theme)
			end
			require("plenary.reload").reload_module("themes")
			vim.cmd.stopinsert()
		end,
	})

	require("theme.mappings")

	if opts.mappings then
		opts.mappings(state.input_buf)
	end
end

return M
