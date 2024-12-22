return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },

    keys = function()
        local mappings = {
            { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>",   desc = "Find Files" },
            { "<leader>fs", "<cmd>Telescope persisted<cr>",    desc = "Find Sessions" },
            { "<leader>fm", "<cmd>Telescope marks<cr>",        desc = "Find Marks" },
            { "<leader>fM", "<cmd>Telescope man_pages<cr>",    desc = "Find Man Pages" },
            { "<leader>fw", "<cmd>Telescope live_grep<cr>",    desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "Find Buffers" },
            { "<leader>fp", "<cmd>Telescope projects<cr>",     desc = "Find Projects" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Find Help" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",      desc = "Find Keymaps" },
            { "<leader>fc", "<cmd>Telescope commands<cr>",     desc = "Find Commands" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",     desc = "Find Recent Files" },
            { "<leader>fh", "<cmd>Telescope highlights<cr>",   desc = "Find Highlights" },
            { "<leader>ft", "<cmd>NvimTheme<cr>",              desc = "Find Themes" },
            { "<leader>fn", "<cmd>enew<cr>",                   desc = "New File" },
        }

        for _, keymap in ipairs(mappings) do
            vim.api.nvim_set_keymap("n", keymap[1], keymap[2], { noremap = true, silent = true, desc = keymap.desc })
        end
    end,

    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.69,
                    height = 0.75,
                    preview_cutoff = 120,
                },
                find_command = {
                    "rg",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = {},
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = {},
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                use_less = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default + actions.center,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        -- even more opts
                    }),
                },
            },
        })
        require("telescope").load_extension("ui-select")
    end,
}
