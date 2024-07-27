local telescopePickers = require("telescope.pickers")
local telescopeFinders = require("telescope.finders")
local telescopeActions = require("telescope.actions")
local telescopeActionState = require("telescope.actions.state")
local telescopeConfig = require("telescope.config").values
local utils = require("core.utils")

local M = {}

local themes = (function()
    local theme_files = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/theme/schemes")
    local theme_names = {}
    for _, file in ipairs(theme_files) do
        table.insert(theme_names, vim.fn.fnamemodify(file, ":r"))
    end
    table.sort(theme_names)
    return theme_names
end)()

local function reloadThemeModule()
    require("plenary.reload").reload_module("theme")
    require("theme").loadThemes()
end

local function applyTheme(theme)
    require("theme").applyTerminalColors(theme)
end

local function updateThemeVariable(theme)
    vim.g.NvimTheme = theme
end

local function replaceThemeInConfig(old_theme, new_theme)
    utils.replaceword("vim.g.NvimTheme", '"' .. old_theme .. '"', '"' .. new_theme .. '"')
end

local function setTheme(theme)
    if not theme then
        return
    end
    local current_theme = vim.g.NvimTheme
    updateThemeVariable(theme)
    applyTheme(theme)
    reloadThemeModule()
    replaceThemeInConfig(current_theme, theme)
end

local function handleTextChangedI()
    if telescopeActionState.get_selected_entry() then
        setTheme(telescopeActionState.get_selected_entry()[1])
    end
end

local function mapTelescopeActions(bufnr, map)
    map("i", "<CR>", function()
        setTheme(telescopeActionState.get_selected_entry()[1])
        telescopeActions.close(bufnr)
    end)

    local function moveSelectionNext()
        telescopeActions.move_selection_next(bufnr)
        setTheme(telescopeActionState.get_selected_entry()[1])
    end

    local function moveSelectionPrevious()
        telescopeActions.move_selection_previous(bufnr)
        setTheme(telescopeActionState.get_selected_entry()[1])
    end

    map("i", "<Down>", moveSelectionNext)
    map("i", "<C-j>", moveSelectionNext)
    map("i", "<Up>", moveSelectionPrevious)
    map("i", "<C-k>", moveSelectionPrevious)
end

local function createAutoCmd(bufnr)
    vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = bufnr,
            callback = function()
                handleTextChangedI()
            end,
        })
    end)
end

function M.setup()
    telescopePickers.new({
        prompt_title = "  COLORSCHEMES",
        layout_config = { height = 0.50, width = 0.50 },
        finder = telescopeFinders.new_table({ results = themes }),
        sorter = telescopeConfig.generic_sorter(),
        attach_mappings = function(bufnr, map)
            createAutoCmd(bufnr)
            mapTelescopeActions(bufnr, map)
            return true
        end,
    }):find()
end

function M.toggleTransparency()
    vim.g.transparency = not vim.g.transparency
    reloadThemeModule()
    utils.replaceword(
        "vim.g.transparency",
        tostring(not vim.g.transparency),
        tostring(vim.g.transparency)
    )
end

function M.random()
    local random_index = math.random(1, #themes)
    local random_theme = themes[random_index]
    setTheme(random_theme)
end

return M

