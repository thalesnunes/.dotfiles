import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = 'mod4'
alt = 'mod1'
home = os.path.expanduser('~')
terminal = guess_terminal(preference='urxvtc')

############################################
################ KEYBINDS ##################
############################################

keys = [
    ############## MOVEMENT ################
    # Switch between windows
    Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, 'shift'], 'h', lazy.layout.shuffle_left(),
        desc='Move window to the left'
    ),
    Key(
        [mod, 'shift'], 'l', lazy.layout.shuffle_right(),
        desc='Move window to the right',
    ),
    Key(
        [mod, 'shift'], 'j', lazy.layout.shuffle_down(),
        desc='Move window down'
    ),
    Key(
        [mod, 'shift'], 'k', lazy.layout.shuffle_up(),
        desc='Move window up'
    ),

    Key([mod], 'o', lazy.next_screen(), desc='Next monitor'),
    Key([mod], 'i', lazy.prev_screen(), desc='Previous monitor'),
    Key(
        [mod, 'shift'], 'o', lazy.window.next_screen(),
        desc='Next monitor'
    ),
    Key(
        [mod, 'shift'], 'i', lazy.window.prev_screen(),
        desc='Previous monitor'
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod], 'comma', lazy.layout.shrink(),
        desc='Grow window to the left'
    ),
    Key(
        [mod], 'period', lazy.layout.grow(),
        desc='Grow window to the right'
    ),
    Key(
        [mod, 'shift'], 'comma', lazy.layout.grow_down(),
        desc='Grow window down'
    ),
    Key(
        [mod, 'shift'], 'period', lazy.layout.grow_up(),
        desc='Grow window up'
    ),
    Key(
        [mod, 'shift'], 'n', lazy.layout.normalize(),
        desc='Reset all window sizes'
    ),

    ############## GENERAL ################
    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.next_layout(), desc='Toggle between layouts'),
    Key(
        [mod, 'shift'], 'Tab', lazy.prev_layout(),
        desc='Toggle between layouts'
    ),
    Key([mod], 'BackSpace', lazy.window.kill(), desc='Kill focused window'),
    Key([alt], 'q', lazy.window.kill(), desc='Kill focused window'),
    Key([mod, 'shift'], 'r', lazy.restart(), desc='Restart Qtile'),
    Key(
        [mod, 'shift'], 'f', lazy.window.toggle_floating(),
        desc='Toggle Floating'
    ),
    Key([mod], 'f', lazy.window.toggle_fullscreen(), desc='Toggle Fullscreen'),

    ########### SYSTEM BINDS ##############
    Key(
        [mod], 'r', lazy.spawncmd(),
        desc='Spawn a command using a prompt widget'
    ),
    Key([mod], 'Return', lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod, 'shift'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    Key(
        [alt, 'control'], 'Delete',
        lazy.spawn(home + '/.config/rofi/pipeline.sh Power'),
        desc='Open rofi Power menu',
    ),
    Key(
        [], 'XF86AudioRaiseVolume',
        lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +10%'),
        desc='Raise volume by 10%'
    ),
    Key(
        [], 'XF86AudioLowerVolume',
        lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -10%'),
        desc='Lower volume by 10%'
    ),
    Key(
        [], 'XF86AudioMute',
        lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'),
        desc='Mute'
    ),

    ########## PERSONAL BINDS #############
    Key(
        [mod], 'b',
        lazy.spawn("brave --profile-directory='Default'"),
        desc='Launch Brave on Default Profile',
    ),
    Key(
        [mod], 'u',
        lazy.spawn("brave --profile-directory='Profile 1'"),
        desc='Launch Brave on USP Profile',
    ),
    Key([mod], 'm', lazy.spawn('telegram-desktop'), desc='Launch Telegram'),
    Key(
        [mod], 'n',
        lazy.spawn(home + '/Scripts/whatsapp_init.sh'),
        desc='Launch WhatsappWeb',
    ),
    Key([mod], 'e', lazy.spawn(terminal + ' -e ranger'), desc='Launch Ranger'),
    Key([mod, 'shift'], 'e', lazy.spawn('pcmanfm'), desc='Launch Pcmanfm'),
    Key(
        [mod, 'shift'], 's', lazy.spawn('flameshot gui'),
        desc='Launch Pcmanfm'
    ),
    # KeyChord([mod, 'space'])
]

############################################
################# GROUPS ###################
############################################

group_names = [
    {
        'name': 'Pessoal',
        'key': 'F9',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': 'USP',
        'key': 'F10',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': 'Trabalho',
        'key': 'F11',
        'args': {
            'layout': 'monadtall',
            'matches': [Match(wm_class='Google-chrome')]
        },
        'screen': 0
    },
    {
        'name': '4',
        'key': '4',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': '5',
        'key': '5',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': '6',
        'key': '6',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': '7',
        'key': '7',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': '8',
        'key': '8',
        'args': {'layout': 'monadtall'},
        'screen': 0
    },
    {
        'name': '9',
        'key': '9',
        'args': {'layout': 'monadtall'},
        'screen': 1
    },
    {
        'name': 'Outros',
        'key': 'F12',
        'args': {
            'layout': 'verticaltile',
            'matches': [
                Match(wm_class='TelegramDesktop'),
                Match(wm_class='whatsappweb-nativefier*'),
                Match(wm_class='notion-nativefier*'),
                Match(wm_class='Slack'),
            ],
        },
        'screen': 1,
    },
]

groups = []

for group in group_names:
    # Create Group
    groups.append(Group(group['name'], **group['args']))
    # Switch to Group
    keys.append(
        Key(
            [mod], group['key'],
            lazy.group[group['name']].toscreen(group['screen'], toggle=False),
            lazy.to_screen(group['screen']),
            desc='Switch to group {}'.format(group['name']),
        )
    )
    # Move container to Group
    keys.append(
        Key(
            [mod, 'shift'], group['key'],
            lazy.window.togroup(group['name']),
            lazy.to_screen(group['screen']),
            desc='Switch to & move focused window to group {}'
            .format(group['name']),
        )
    )

layout_theme = {
    'border_width': 2,
    'margin': 8,
    'border_focus': 'f0a830',
    'border_normal': '907878',
}

layouts = [
    # layout.Columns(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(
    font='Noto Sans',
    fontsize=11,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format='%H:%M | %d %b'),
                widget.GroupBox(),
                widget.Systray(),
            ],
            24,
            background='#FFFFFF00',
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], 'Button3', lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[

        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(wm_class='flameshot'),  # flameshot
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = 'focus'
reconfigure_screens = True


@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/autostart_once.sh'])


@hook.subscribe.startup
def start_always():
    subprocess.call([home + '/.config/qtile/autostart_always.sh'])


# def focus_group():
#     curr_screen = qtile.screens


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'
