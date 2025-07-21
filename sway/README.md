# Sway Configuration

This directory contains a complete Sway window manager configuration ported from the original i3 setup. This configuration maintains the same keybindings, layout, and workflow while adapting to Wayland/Sway-specific tools and features.

## Migration Overview

This configuration replaces X11-specific tools with their Wayland equivalents while preserving the same functionality and user experience.

### Tool Replacements

The following tools have been replaced according to the Wayland migration plan:

| X11 Tool | Wayland Replacement | Status |
|----------|-------------------|--------|
| `clipcat` | `clipse` | ✅ Configured |
| `feh` | `swaybg` | ✅ Configured |
| `maim` | `grim` + `slurp` | ✅ Configured |
| `polybar` | `waybar` | ✅ Configured |
| `redshift` | `gammastep` | ✅ Configured |
| `rofi` | `wofi` | ✅ Configured |
| `xclip` | `wl-clipboard` | ✅ Configured |
| `dunst` | `mako` | ✅ Configured |

## Directory Structure

```
sway/
├── .config/
│   ├── sway/
│   │   └── config              # Main sway configuration
│   ├── waybar/
│   │   ├── config              # Waybar configuration
│   │   └── style.css           # Waybar Dracula theme
│   ├── mako/
│   │   └── config              # Notification daemon config
│   ├── wofi/
│   │   ├── config              # Application launcher config
│   │   ├── style.css           # Wofi Dracula theme
│   │   └── scripts/
│   │       └── launch          # Launch script (replaces rofi)
│   └── ...
├── .local/
│   └── bin/
│       └── grim_monitor        # Screenshot helper script
└── README.md                   # This file
```

## Key Features Preserved

### Window Management
- ✅ Same keybindings (`$mod+hjkl` for navigation)
- ✅ Workspace assignments (1-5 on primary, 6-10 on secondary)
- ✅ Application-specific workspace assignments
- ✅ Floating window rules
- ✅ Resize bindings and modes
- ✅ 8px inner gaps with smart gaps

### Visual Theme
- ✅ Dracula color scheme maintained across all components
- ✅ Same window borders and colors
- ✅ Consistent theming for waybar, wofi, and mako
- ✅ Noto Sans font family

### Custom Modes
- ✅ **APPS mode** (`$mod+space`): Quick access to various applications
- ✅ **SCREENSHOT mode** (`$mod+s`): Various screenshot options
- ✅ **WORK mode** (`$mod+w`): Work-related applications
- ✅ **SPOTIFY mode**: Spotify controls (within APPS mode)
- ✅ **Resize mode** (`$mod+r`): Window resizing

### Media and System Controls
- ✅ Volume controls (XF86Audio* keys)
- ✅ Brightness controls (XF86MonBrightness* keys)
- ✅ Media player controls (playerctl)
- ✅ Notification controls (mako instead of dunst)

## New Wayland-Specific Features

### Enhanced Screenshot Functionality
- **Region selection**: `grim -g "$(slurp)" - | wl-copy`
- **Window capture**: Improved with sway's tree structure
- **Multi-monitor support**: `grim_monitor` script for specific outputs

### Input Configuration
- **Touchpad settings**: Natural scrolling, tap-to-click, dwt
- **Keyboard settings**: Repeat rate and delay configuration
- **Per-device configuration**: Type-based input settings

### Output Management
- **Wallpaper**: Managed by sway's built-in `output * bg` command
- **Monitor configuration**: Native sway output commands
- **Adaptive sync**: Available through sway configuration

## Installation Requirements

Before using this configuration, ensure the following packages are installed:

### Core Sway Components
```bash
# Essential sway packages
sway waybar mako wofi

# Screenshot and clipboard tools
grim slurp wl-clipboard clipse

# Audio and media
pulseaudio pavucontrol playerctl

# Brightness control
brightnessctl

# Blue light filter
gammastep

# System utilities
nm-applet blueman-applet udiskie
polkit-gnome swaylock swayidle
```

### Font Requirements
```bash
# Install Noto Sans and Font Awesome for proper rendering
noto-fonts noto-fonts-emoji ttf-font-awesome
```

## Configuration Adaptations

### Sway-Specific Changes

1. **Input Configuration**: Added touchpad and keyboard settings in the main config
2. **Output Configuration**: Uses sway's native output commands instead of xrandr
3. **Idle Management**: Uses `swayidle` and `swaylock` for screen locking
4. **Wallpaper**: Uses sway's built-in wallpaper setting

### Key Binding Updates

Most keybindings remain identical, with these notable changes:
- Screenshot commands now use `grim`/`slurp` instead of `maim`
- Clipboard operations use `wl-copy`/`wl-paste` instead of `xclip`
- Notification controls use `makoctl` instead of `dunstctl`

### Application Launcher Updates

The wofi launcher script (`wofi/scripts/launch`) provides the same functionality as the original rofi scripts:
- **Power menu**: Lock, logout, suspend, reboot, shutdown
- **Bluetooth menu**: Basic bluetooth controls
- **MPV menu**: Media playback options
- **Default launcher**: Application menu

## Usage Notes

### First Time Setup

1. **Copy the configuration**:
   ```bash
   cp -r sway/.config/* ~/.config/
   cp -r sway/.local/* ~/.local/
   ```

2. **Set XDG_CONFIG_HOME** (if not already set):
   ```bash
   export XDG_CONFIG_HOME="$HOME/.config"
   ```

3. **Start sway**:
   ```bash
   sway
   ```

### Customization

- **Monitor setup**: Edit the `output` commands in `sway/config`
- **Wallpaper**: Place your wallpaper at `~/.config/sway/wallpaper.jpg` or modify the path
- **Colors**: All components use the Dracula theme; modify the hex colors consistently across configs
- **Keybindings**: Maintain the same structure as the original i3 config for consistency

### Troubleshooting

- **Missing fonts**: Install `noto-fonts` and `ttf-font-awesome`
- **Screenshot issues**: Ensure `grim`, `slurp`, and `wl-clipboard` are installed
- **Waybar not appearing**: Check that waybar is installed and the config syntax is valid
- **Input not working**: Use `swaymsg -t get_inputs` to identify device names

## Migration Notes

This configuration maintains 95%+ compatibility with the original i3 workflow. The main differences you'll notice:

1. **Faster performance**: Wayland's efficiency improvements
2. **Better multi-monitor support**: Native fractional scaling and per-output configuration
3. **Improved security**: Wayland's security model
4. **Better touchpad support**: Native gesture support

The transition should be seamless for daily usage, with all familiar keybindings and workflows preserved. 