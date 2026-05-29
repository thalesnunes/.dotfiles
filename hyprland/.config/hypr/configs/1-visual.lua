hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 0,
        border_size = 2,
        no_gaps_when_only = false,
    },
    decoration = {
        rounding = 14,
        drop_shadow = true,
        shadow_range = 20,
        shadow_offset = "0 4",
        blur = {
            enabled = true,
            size = 10,
            passes = 3,
        },
    },
    cursor = {
        no_warf = true,
        inactive_timeout = 0,
    },
    input = {
        follow_mouse = 0,
    },
    xwayland = {
        enabled = true,
    },
})
