local wezterm = require("wezterm")
local hyperlinks = require("hyperlinks")
local fonts = require("fonts")

local config = {
    term = "wezterm",
    font = wezterm.font_with_fallback({
        fonts.geist_mono,
        fonts.jetbrains_mono,
    }),
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    window_background_opacity = 1,
    macos_window_background_blur = 25,
    font_size = 18.0,
    line_height = 1.22,
    cell_width = 0.95,
    color_scheme = "tokyonight_night",
    enable_tab_bar = false,
    send_composed_key_when_right_alt_is_pressed = false,
    hyperlink_rules = hyperlinks.default_hyperlinks_with({
        hyperlinks.numeric_hyperlinks,
        hyperlinks.github_hyperlinks,
    }),
}

return config
