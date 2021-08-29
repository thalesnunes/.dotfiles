require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = {'|', '|'},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
        'filename',
        {
            'diagnostics',
            sources = {'nvim_lsp'}
        }
    },
    lualine_x = {'filetype'},
    lualine_y = {
        {
            'diff',
            color_added = '#02f702',
            color_modified = '#efd402',
            color_removed = '#ea000f'
        }
    },
    lualine_z = {'location'}
  }
}
