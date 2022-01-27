-- Change background color for better compatibility with tmux
local custom_dracula = require('lualine.themes.dracula')
local new_bg = '#262626'
custom_dracula.normal.c.bg = new_bg
custom_dracula.insert.c.bg = new_bg
custom_dracula.visual.c.bg = new_bg
custom_dracula.replace.c.bg = new_bg
custom_dracula.command.c.bg = new_bg
custom_dracula.inactive.c.bg = new_bg

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = custom_dracula,
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
