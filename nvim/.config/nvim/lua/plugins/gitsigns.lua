require('gitsigns').setup {
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    attach_to_untracked = true,
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
}
