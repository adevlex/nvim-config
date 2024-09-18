return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>f",  group = "file" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files", mode = "n" },
        })
    end,
}
