return {
    {
        'Kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'VeryLazy',
        init = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.foldmethod = 'indent'
            vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }
        end,
        opts = {
            provider_selector = function(_, _, _)
                return { 'treesitter', 'indent' }
            end,
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require "statuscol.builtin"
            require("statuscol").setup {
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    { text = { "%s" },                  click = "v:lua.ScSa" },
                },
            }
        end,
    },
}
