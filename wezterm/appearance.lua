local wezterm = require("wezterm")

local M = {}
M.__index = M

function M:init()
	local appearance = {}
	setmetatable(appearance, M)

	appearance:set_color_scheme()
	appearance:set_window_size()
	appearance:set_background()
	appearance:set_gpu_options(appearance:get_gpu_options())
	appearance:set_alt_options()

	print(appearance)
	return appearance
end

function M:get_gpu_options()
	local gpu_adapter = require("utils.gpu-adapter"):init():pick_best()
	local gpu_config = {
		front_end = "Software",
		animation_fps = 1,
		max_fps = 60,
	}

	if gpu_adapter ~= nil then
		gpu_config.front_end = "WebGpu"
		gpu_config.webgpu_preferred_adapter = gpu_adapter
		gpu_config.animation_fps = 60
	end

	return gpu_config
end

function M:set_gpu_options(gpu_options)
	self.front_end = gpu_options.front_end
	self.webgpu_preferred_adapter = gpu_options.webgpu_preferred_adapter
	self.animation_fps = gpu_options.animation_fps
	self.max_fps = gpu_options.max_fps
end

function M:set_background()
	if wezterm.GLOBAL.background == nil then
		return
	end

	-- background image
	self.background = {
		{
			source = {
				File = wezterm.GLOBAL.background,
			},
			hsb = {
				brightness = 0.5,
				hue = 1.0,
				saturation = 1.0,
			},
			horizontal_align = "Center",
			opacity = 1.0,
		},
	}
end

function M:set_alt_options()
	-- treat option as alt on macos
	self.send_composed_key_when_left_alt_is_pressed = false
	self.send_composed_key_when_right_alt_is_pressed = false
end

function M:set_color_scheme()
	-- self.color_scheme = "Tomorrow Night Eighties"
	self.color_scheme = "ayu"
end

function M:set_window_size()
	self.initial_rows = 30
	self.initial_cols = 140
end

return M
