BIN = os.getenv("XDG_USER_BIN")
CONFIG_DIR = os.getenv("XDG_CONFIG_HOME")
HOME = os.getenv("HOME")

TERMINAL = "footclient"
TERMINAL_SERVER = "foot --server"

local onscreen_bar = BIN .. "/onscreen_bar"

BRIGHTNESS_UP = "brightnessctl set +10% && "
	.. onscreen_bar
	.. ' Brightness $(echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc)'
BRIGHTNESS_DOWN = "brightnessctl set 10%- && "
	.. onscreen_bar
	.. ' Brightness $(echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc)'
BRIGHTNESS_MAX = "brightnessctl set 100% && "
	.. onscreen_bar
	.. ' Brightness $(echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc)'
BRIGHTNESS_MIN = "brightnessctl set 0% && "
	.. onscreen_bar
	.. ' Brightness $(echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc)'

VOLUME_DOWN = "pulsemixer --change-volume -5 && " .. onscreen_bar .. " Volume $(pulsemixer --get-volume)"
VOLUME_UP = "pulsemixer --change-volume +5 && " .. onscreen_bar .. " Volume $(pulsemixer --get-volume)"
VOLUME_MUTE = "pulsemixer --toggle-mute"

PLAY_PAUSE_TOGGLE = "playerctl play-pause"
PLAY_NEXT = "playerctl next"
PLAY_PREVIOUS = "playerctl previous"

local grimshot = "/usr/bin/grimshot"
SCREENSHOT_WINDOW = grimshot .. " --notify copy anything"
SCREENSHOT_ACTIVE = grimshot .. " --notify copy active"
SCREENSHOT_OUTPUT = grimshot .. " --notify copy output"

SCREENSHOT_SAVE = "wl-paste -t image/png > " .. HOME .. "/Images/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
SCREENSHOT_ANNOTATE = "wl-paste -t image/png | satty -f -"

CLOSE_NOTIFICATION = "makoctl dismiss"
CLOSE_ALL_NOTIFICATIONS = "makoctl dismiss --all"
REDISPLAY_LAST_NOTIFICATION = "makoctl restore"

OPEN_CALENDAR = 'zsh -i -c "gcal_notifier print m; read -k"'

LOCK = "hyprlock"
IDLE = "hypridle"
SUSPEND = "systemctl suspend"

-------- AUTOSTART ------------
DESKTOP_SETUP = BIN .. "/desktop_setup"

CLIPHIST = "wl-paste --watch cliphist store"
MAKO = "mako"
UDISKIE = "udiskie -t"
WLSUNSET = 'wlsunset -l "-23.536215622740578" -L "-46.68497829306198" -t "3500" -T "6500" -d "1800" &'
