return {
    'terrortylor/nvim-comment',
    event = 'BufRead',
    config = function()
        require('nvim_comment').setup({
            line_mapping = "<leader>/",
            operator_mapping = "<leader>/",
            comment_chunk_text_object = "ic"
        })
    end
}
