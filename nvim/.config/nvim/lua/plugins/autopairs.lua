return {
    {
        "m4xshen/autoclose.nvim",
        event = "VimEnter",
        config = function ()
            require("autoclose").setup {
                options = {
                    pair_spaces = true
                }
            }
        end
    },
    {
        "machakann/vim-sandwich",
        event = { "BufReadPre", "BufNewFile" },
        keys = { "sa", "sd", "sr" }
    }
}
