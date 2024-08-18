local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tomorrow Night Eighties"

-- treat option as alt on macos
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- background image
config.window_background_image = wezterm.config_dir .. "/backdrops/moon.jpg"
config.window_background_image_hsb = {
	brightness = 0.5,
	hue = 1.0,
	saturation = 1.0,
}
config.window_background_opacity = 1.0

return config
