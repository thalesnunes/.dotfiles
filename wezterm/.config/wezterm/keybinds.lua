local wezterm = require("wezterm")
local act = wezterm.action

return {
	keys = {
		-- Zooming and resizing
		{ key = "F12", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	},
}
