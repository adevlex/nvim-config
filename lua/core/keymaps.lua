-- Definir la función ClickGit en el ámbito global
function ClickGit()
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
    local lazygit = Terminal:new { cmd = "lazygit", direction = "float", hidden = true }
    lazygit:toggle()
end

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("n", "<C-a>", "gg<S-v>G")
map("n", "<C-b>", "<cmd>lua require\'core.functions\'.build_run()<CR>")
-- Nvim-Tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
-- Debugger
map('n', '<leader>dc', '<cmd>lua require\'dap\'.continue()<CR>')
map('n', '<leader>do', '<cmd>lua require\'dap\'.step_over()<CR>')
map('n', '<leader>di', '<cmd>lua require\'dap\'.step_into()<CR>')
map('n', '<leader>du', '<cmd>lua require\'dap\'.step_out()<CR>')
map('n', '<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
map('n', '<leader>dB', '<cmd>lua require\'dap\'.set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>')
map('n', '<leader>dd', '<cmd>lua require\'dapui\'.toggle()<CR>')
map('n', '<leader>dl', '<cmd>lua require\'dap\'.run_last()<CR>')

-- Find
map('n', '<leader>fa', '<cmd>Telescope autocommands<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fs', '<cmd>Telescope persisted<CR>')
map('n', '<leader>fm', '<cmd>Telescope marks<CR>')
map('n', '<leader>fM', '<cmd>Telescope man_pages<CR>')
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fn', '<cmd>lua require(\'telescope\').extensions.notify.notify()<CR>')
map('n', '<leader>fp', '<cmd>Telescope projects<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fk', '<cmd>Telescope keymaps<CR>')
map('n', '<leader>fC', '<cmd>Telescope commands<CR>')
map('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')
map('n', '<leader>fH', '<cmd>Telescope highlights<CR>')

-- Git
map('n', '<leader>go', '<cmd>Telescope git_status<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>gg', ':lua ClickGit()<CR>')
map('n', '<leader>gj', '<cmd>lua require\'gitsigns\'.next_hunk()<CR>')
map('n', '<leader>gk', '<cmd>lua require\'gitsigns\'.prev_hunk()<CR>')
map('n', '<leader>gl', '<cmd>lua require\'gitsigns\'.blame_line()<CR>')
map('n', '<leader>gp', '<cmd>lua require\'gitsigns\'.preview_hunk()<CR>')
map('n', '<leader>gr', '<cmd>lua require\'gitsigns\'.reset_hunk()<CR>')
map('n', '<leader>gR', '<cmd>lua require\'gitsigns\'.reset_buffer()<CR>')
map('n', '<leader>gs', '<cmd>lua require\'gitsigns\'.stage_hunk()<CR>')
map('n', '<leader>gu', '<cmd>lua require\'gitsigns\'.undo_stage_hunk()<CR>')
map('n', '<leader>gd',
    ':lua if next(require("diffview.lib").views) == nil then vim.cmd("DiffviewOpen") else vim.cmd("DiffviewClose") end<CR>')

-- LSP
map('n', '<leader>lk', '<cmd>Lspsaga hover_doc<CR>')
map('n', '<leader>le', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '<leader>la', '<cmd>Lspsaga code_action<CR>')
map('n', '<leader>lo', '<cmd>Lspsaga outline<CR>')
map('n', '<leader>lI', '<cmd>Lspsaga incoming_calls<CR>')
map('n', '<leader>lO', '<cmd>Lspsaga outgoing_calls<CR>')
map('n', '<leader>lr', '<cmd>Lspsaga rename<CR>')
map('n', '<leader>li', '<cmd>LspInfo<CR>')

-- Neovim
local config_dir = { vim.fn.stdpath("config") .. "/" }
map('n', '<leader>nf',
    ':lua require("telescope.builtin").find_files{prompt_title="Config Files", search_dirs=config_dir, cwd=vim.fn.stdpath("config").."/"}<CR>')
map('n', '<leader>ng',
    ':lua require("telescope.builtin").live_grep{prompt_title="Config Files", search_dirs=config_dir, cwd=vim.fn.stdpath("config").."/"}<CR>')
map('n', '<leader>ni',
    ':lua if vim.fn.has("nvim-0.9.0") == 1 then vim.cmd("Inspect") else vim.notify("Inspect isn\'t available in this Neovim version", vim.log.levels.WARN, {title="Inspect"}) end<CR>')
map('n', '<leader>nm', '<cmd>messages<CR>')
map('n', '<leader>nh', '<cmd>checkhealth<CR>')
map('n', '<leader>nv',
    ':lua local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch vim.notify(version, vim.log.levels.INFO, {title="Neovim Version"})<CR>')

-- Plugins
map('n', '<leader>pc', '<cmd>Lazy clean<CR>')
map('n', '<leader>pC', '<cmd>Lazy check<CR>')
map('n', '<leader>pd', '<cmd>Lazy debug<CR>')
map('n', '<leader>pi', '<cmd>Lazy install<CR>')
map('n', '<leader>ps', '<cmd>Lazy sync<CR>')
map('n', '<leader>pl', '<cmd>Lazy log<CR>')
map('n', '<leader>ph', '<cmd>Lazy home<CR>')
map('n', '<leader>pH', '<cmd>Lazy help<CR>')
map('n', '<leader>pp', '<cmd>Lazy profile<CR>')
map('n', '<leader>pu', '<cmd>Lazy update<CR>')

-- Terminal
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>')
map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>')
map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>')

-- Minty
-- Definir el keymap para activar minty.huefy y minty.shades
map("n", "<leader>mh", ":lua require('minty.huefy').open()<CR>", { noremap = true, silent = true })
map("n", "<leader>ms", ":lua require('minty.shades').open()<CR>", { noremap = true, silent = true })
