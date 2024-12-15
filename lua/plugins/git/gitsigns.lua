return
{
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    opts = {
        signs = {
            delete = { text = "󰍵" },
            changedelete = { text = "󱕖" },
        },
    }
}
