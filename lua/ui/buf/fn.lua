local M = {}

-- Utility function to get the buffer name or an empty string if the buffer is not named
local function get_buffer_name(buf)
    return (#vim.api.nvim_buf_get_name(buf) ~= 0) and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") or ""
end

-- Utility function to check if a buffer is valid and listed
local function is_buffer_valid_and_listed(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_is_loaded(buf)
end

-- Function to filter buffers according to specific criteria
M.bufilter = function()
    local bufs = vim.api.nvim_list_bufs() or {}

    -- Guard clause for empty buffer list
    if #bufs == 0 then
        return {}
    end

    for i = #bufs, 1, -1 do
        if not is_buffer_valid_and_listed(bufs[i]) or get_buffer_name(bufs[i]) == '' then
            table.remove(bufs, i)
        end
    end

    return bufs
end

-- Function to switch to the previous buffer
M.tabuflinePrev = function()
    local bufs = M.bufilter()
    local current_buf = vim.api.nvim_get_current_buf()

    for i, buf in ipairs(bufs) do
        if current_buf == buf then
            vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
            break
        end
    end
end

-- Function to switch to the next buffer
M.tabuflineNext = function()
    local bufs = M.bufilter()
    local current_buf = vim.api.nvim_get_current_buf()

    for i, buf in ipairs(bufs) do
        if current_buf == buf then
            vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
            break
        end
    end
end

-- Function to close a buffer
M.close_buffer = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- Guard clause for terminal buffer
    if vim.bo.buftype == "terminal" then
        vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
        return
    end

    if bufnr == vim.api.nvim_get_current_buf() then
        M.tabuflinePrev()
    end
    vim.cmd("confirm bd" .. bufnr)
end

return M
