local wezterm = require 'wezterm'
local act = wezterm.action

return {
    keys = {
        -- Scrollback and movement
        { key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
        { key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
        { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
        { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

        -- Multiple line terminal input
        { key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },

        -- Activate visual mode
        { key = "v", mods = "ALT", action = "ActivateCopyMode" },

        -- Zooming and resizing
        { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
        { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
        { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
        { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
        { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
        { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
        { key = '0', mods = 'CTRL', action = act.ResetFontSize },
        { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },

        -- Copy and pasting
        { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
        { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
        { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
        { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
        { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
        { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
        { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },

        -- Hot reload config
        { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
        { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },

        -- Emoji selection
        { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
        { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    },

    key_tables = {
        -- Visual mode vim keybinds
        copy_mode = {
            { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
            { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
            { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
            { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
            { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
            { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
            { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
            { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
            { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
            { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
            { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
            { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
            { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
            { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
            { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
            { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
            { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
            { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
            { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
            { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
            { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
            { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
            { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
            { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
            { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
            { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
            { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
            { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
            { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
            { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
            { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
            { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
            { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
            { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
            { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
            { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
            { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
            { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
            { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
            { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
            { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
            { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
            { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
            { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
            { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
        },

        -- Search mode default
        search_mode = {
            { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
            { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
            { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
            { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
            { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
            { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
            { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
            { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
            { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
            { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
        },

    }
}
