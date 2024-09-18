local M = {}

local function notify(message, level, options)
    vim.notify(message, level or vim.log.levels.INFO, options)
end

local function substitute(cmd)
    return cmd:gsub("%%", vim.fn.expand "%")
        :gsub("$fileBase", vim.fn.expand "%:r")
        :gsub("$filePath", vim.fn.expand "%:p")
        :gsub("$file", vim.fn.expand "%")
        :gsub("$dir", vim.fn.expand "%:p:h")
        :gsub("#", vim.fn.expand "#")
        :gsub("$altFile", vim.fn.expand "#")
end

local function toggle_option(option)
    local value = not vim.api.nvim_get_option_value(option, {})
    vim.opt[option] = value
    notify(option .. " set to " .. tostring(value))
end

local function toggle_tabline()
    local value = vim.api.nvim_get_option_value("showtabline", {})
    value = value == 2 and 0 or 2
    vim.opt.showtabline = value
    notify("showtabline set to " .. tostring(value))
end

local function build_run()
    local file_extension = vim.fn.expand "%:e"
    local term_cmd = "bot 10 new | term "

    local supported_filetypes = {
        html = { default = "live-server ." },
        c = { default = "gcc % -o $fileBase && ./$fileBase", debug = "gcc -g % -o $fileBase && $fileBase" },
        cs = { default = "dotnet run" },
        cpp = { default = "g++ % -o  $fileBase && ./$fileBase", debug = "g++ -g % -o  $fileBase", competitive = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase" },
        py = { default = "python %" },
        go = { default = "go run %" },
        java = { default = "java %" },
        js = { default = "node %", debug = "node --inspect %" },
        ts = { default = "tsc % && node $fileBase" },
        rs = { default = "rustc % && $fileBase" },
        php = { default = "php %" },
        r = { default = "Rscript %" },
        jl = { default = "julia %" },
        rb = { default = "ruby %" },
        pl = { default = "perl %" },
        tex = { default = "pdflatex %" },
    }

    local function execute_command(cmd)
        vim.cmd(term_cmd .. substitute(cmd))
    end

    if not supported_filetypes[file_extension] then
        notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = "Code Runner" })
        return
    end

    local options = vim.tbl_keys(supported_filetypes[file_extension])
    if #options == 0 then
        notify("It doesn't contain any command", vim.log.levels.WARN, { title = "Code Runner" })
        return
    end

    if #options == 1 then
        execute_command(supported_filetypes[file_extension][options[1]])
        return
    end

    vim.ui.select(options, { prompt = "Choose a command: " }, function(option)
        local selected_cmd = supported_filetypes[file_extension][option]
        if selected_cmd then
            execute_command(selected_cmd)
        end
    end)
end

local function lazygit_toggle()
    local lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = { border = "curved" },
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
    })
    lazygit:toggle()
end

local function ranger_toggle()
    if vim.fn.executable("ranger") == 0 then
        notify("ranger isn't installed")
        return
    end

    local ranger = require("toggleterm.terminal").Terminal:new({
        cmd = "ranger",
        direction = "float",
        on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
    })
    ranger:toggle()
end

M.toggle_option = toggle_option
M.toggle_tabline = toggle_tabline
M.build_run = build_run
M.lazygit_toggle = lazygit_toggle
M.ranger_toggle = ranger_toggle

return M
