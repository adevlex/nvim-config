return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")
        require("notify").setup({
            level = 2,
            minimum_width = 50,
            render = "minimal",
            stages = "fade",
            timeout = 2000,
            top_down = true,
            background_colour = "#000000",
        })
    end
}
