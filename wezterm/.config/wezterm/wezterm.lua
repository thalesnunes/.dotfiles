local keybinds = require("keybinds")

return {
	-- font = wezterm.font("MesloLGS NF"),
	font_size = 14,
	color_scheme = "Dracula",
	default_cursor_style = "SteadyBlock",
	warn_about_missing_glyphs = false,

	enable_tab_bar = false,
	window_padding = {
		left = 6,
		right = 6,
		top = 6,
		bottom = 0,
	},
	window_decorations = "RESIZE",
	window_background_opacity = 0.9,
	adjust_window_size_when_changing_font_size = false,

	check_for_updates = false,

	disable_default_key_bindings = true,
	keys = keybinds["keys"],
	key_tables = keybinds["key_tables"],
}
