require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula-nvim',
    component_separators = {left = '|', right = '|'},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {
        {
            'mode',
            fmt = function(mode) return mode:sub(1,1) end,
        }
    },
    lualine_b = {'branch'},
    lualine_c = {
        'filename',
        {
            'diagnostics',
            sources = {'nvim_diagnostic'}
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
