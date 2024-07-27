local custom_autocmd_group = vim.api.nvim_create_augroup("CustomAutocmdGroup", { clear = true })

-- Utilities
local function is_directory(path)
    return vim.fn.isdirectory(path) == 1
end

local function should_format_buffer()
    for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
            return true
        end
    end
    return false
end

local function should_skip_alpha()
    if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
        return true
    end

    for _, arg in pairs(vim.v.argv) do
        if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            return true
        end
    end

    return false
end

local function reload_neovim_config()
    local fp = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
    vim.cmd("silent source %")
    if vim.g.loadNvimTheme then
        require("plenary.reload").reload_module("theme")
    end
    require("plenary.reload").reload_module(module)
    if vim.g.loadNvimTheme then
        require("theme").loadThemes()
    end
end

-- Autocommands
-- Forma code to save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        if should_format_buffer() then
            vim.lsp.buf.format()
        end
    end
})

vim.api.nvim_create_autocmd({ "UIEnter" }, {
    callback = function()
        if vim.g.loadNvimTheme then
            dofile(vim.g.themeCache .. "allThemes")
        end

        if should_skip_alpha() then
            return
        end

        vim.cmd("Alpha")
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        if not is_directory(data.file) then
            return
        end

        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
    end
})

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float({ scope = "cursor", focusable = false })
    end,
    desc = "Open Float Window for LSP Diagnostics",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = custom_autocmd_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = custom_autocmd_group,
    callback = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
            vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close<cr>", {
                silent = true,
                noremap = true,
            })
        end
    end,
    desc = "Make q close help, man, quickfix, dap floats",
})

vim.api.nvim_create_autocmd("FileType", {
    group = custom_autocmd_group,
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
    desc = "Don't list quickfix buffer",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = custom_autocmd_group,
    pattern = vim.fn.stdpath("config") .. "/lua/*.lua",
    callback = reload_neovim_config,
    desc = "Reload neovim config on save",
})

-- User commands
vim.api.nvim_create_user_command("NvimTheme", function()
    require("theme.pick").setup()
end, {})

vim.api.nvim_create_user_command("NvimToggleTrans", function()
    require("theme.pick").toggleTransparency()
end, {})

vim.api.nvim_create_user_command("Ranger", function()
    require("core.utils").Ranger()
end, {})
