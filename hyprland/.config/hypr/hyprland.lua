hl.env({
	XDG_CURRENT_DESKTOP = "Hyprland",
	XDG_SESSION_TYPE = "wayland",
	XDG_SESSION_DESKTOP = "Hyprland",
})

dofile("./configs/0-variables.lua")
dofile("./configs/1-visual.lua")
dofile("./configs/2-window_rules.lua")
dofile("./configs/3-dracula_theme.lua")
dofile("./configs/4-autostart.lua")

dofile("./inputs/default-keyboard.lua")
dofile("./inputs/default-touchpad.lua")

dofile("./outputs/screen.lua")

dofile("./modes/default.lua")
dofile("./modes/apps.lua")
dofile("./modes/screenshot.lua")
dofile("./modes/work.lua")
