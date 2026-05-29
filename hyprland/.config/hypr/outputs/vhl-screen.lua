local primary = ":PRIMARY_MONITOR"
local secondary = ":SECONDARY_MONITOR"

hl.monitor({
    output = secondary,
    mode = "1920x1080@60.000Hz",
    position = "0 0",
    scale = 1.0,
    transform = 3,
})

hl.monitor({
    output = primary,
    mode = "1920x1080@75.000Hz",
    position = "1080 150",
    scale = 1.0,
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1200@59.999Hz",
    position = "3000 500",
    scale = 1.2,
})

hl.workspace_rule({ workspace = "1", monitor = primary })
hl.workspace_rule({ workspace = "2", monitor = primary })
hl.workspace_rule({ workspace = "3", monitor = primary })
hl.workspace_rule({ workspace = "4", monitor = primary })
hl.workspace_rule({ workspace = "5", monitor = primary })
hl.workspace_rule({ workspace = "6", monitor = secondary })
hl.workspace_rule({ workspace = "7", monitor = secondary })
hl.workspace_rule({ workspace = "8", monitor = secondary })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
