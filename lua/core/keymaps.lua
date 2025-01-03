-- Definir la función ClickGit en el ámbito global
function ClickGit()
	---@diagnostic disable-next-line: unused-local
	local status_ok, toggleterm = pcall(require, "toggleterm")
	if not status_ok then
		vim.notify("toggleterm.nvim isn't installed!!!", vim.log.levels.ERROR)
		return
	end

	-- Verificar si estamos dentro de un repositorio git
	local is_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1]
	if is_git_repo ~= "true" then
		vim.notify("Not inside a git repository. Initialize a git repository first.", vim.log.levels.ERROR)
		return
	end

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
	lazygit:toggle()
end

local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
map("n", "<C-b>", "<cmd>lua require'core.functions'.build_run()<CR>", { desc = "Build and run" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

-- Debugger
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Continue" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Step into" })
map("n", "<leader>du", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Step out" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
map(
	"n",
	"<leader>dB",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Set breakpoint" }
)
map("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle debugger UI" })
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Run last" })

-- Find
map("n", "<leader>fa", "<cmd>Telescope autocommands<CR>", { desc = "Autocommands" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fs", "<cmd>Telescope persisted<CR>", { desc = "Persisted" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>fM", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fn", "<cmd>lua require('telescope').extensions.notify.notify()<CR>", { desc = "Notifications" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Old files" })
map("n", "<leader>fH", "<cmd>Telescope highlights<CR>", { desc = "Highlights" })

-- Git
map("n", "<leader>go", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gg", ":lua ClickGit()<CR>", { desc = "Git commit" })
map("n", "<leader>gj", "<cmd>lua require'gitsigns'.next_hunk()<CR>", { desc = "Next hunk" })
map("n", "<leader>gk", "<cmd>lua require'gitsigns'.prev_hunk()<CR>", { desc = "Prev hunk" })
map("n", "<leader>gl", "<cmd>lua require'gitsigns'.blame_line()<CR>", { desc = "Blame line" })
map("n", "<leader>gp", "<cmd>lua require'gitsigns'.preview_hunk()<CR>", { desc = "Preview hunk" })
map("n", "<leader>gr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>", { desc = "Reset hunk" })
map("n", "<leader>gR", "<cmd>lua require'gitsigns'.reset_buffer()<CR>", { desc = "Reset buffer" })
map("n", "<leader>gs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo stage hunk" })
map(
	"n",
	"<leader>gd",
	":lua if next(require('diffview.lib').views) == nil then vim.cmd('DiffviewOpen') else vim.cmd('DiffviewClose') end<CR>",
	{ desc = "Diff" }
)

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
map("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>ra", function()
	require("core.renamer")()
end, { desc = "NvRenamer" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Plugins
map("n", "<leader>pc", ":Lazy clean<CR>", { desc = "Clean" })
map("n", "<leader>pC", ":Lazy check<CR>", { desc = "Check" })
map("n", "<leader>pd", ":Lazy debug<CR>", { desc = "Debug" })
map("n", "<leader>pi", ":Lazy install<CR>", { desc = "Install" })
map("n", "<leader>ps", ":Lazy sync<CR>", { desc = "Sync" })
map("n", "<leader>pl", ":Lazy log<CR>", { desc = "Log" })
map("n", "<leader>ph", ":Lazy home<CR>", { desc = "Home" })
map("n", "<leader>pH", ":Lazy help<CR>", { desc = "Help" })
map("n", "<leader>pp", ":Lazy profile<CR>", { desc = "Profile" })
map("n", "<leader>pu", ":Lazy update<CR>", { desc = "Update" })

-- Terminal
map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Float" })
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Horizontal" })
map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Vertical" })
map("n", "<leader>tl", ":ToggleTerm<CR>", { desc = "Toggle" })

-- Minty
-- Definir el keymap para activar minty.huefy y minty.shades
map("n", "<leader>mh", ":lua require('minty.huefy').open()<CR>", { noremap = true, silent = true })
map("n", "<leader>ms", ":lua require('minty.shades').open()<CR>", { noremap = true, silent = true })
map("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options, { mouse = true })
end, {})

-- preview mask
map("n", "<leader>fd", function()
	require("core.previewer_mask").masked_search({
		prompt_title = "Buscar Archivos",
		layout_config = { preview_width = 0.6 },
		hidden = true,
	})
end, { noremap = true, silent = true, desc = "Buscar archivos (con datos privados enmascarados)" })

-- Themes
map("n", "<leader>ft", function()
	require("theme.pick").open()
end, { desc = "telescope themes" })
