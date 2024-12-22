local M = {}

function M.safe_toggle_dapui()
    local dap = require("dap")
    local dapui = require("dapui")

    if dap.session() then
        dapui.toggle()
    else
        vim.notify("No active debugging session.", vim.log.levels.WARN, { title = "DAP UI" })
    end
end

return M
