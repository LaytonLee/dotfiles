local wezterm = require("wezterm")
local platform = require("utils.platform")()

local M = {}
M.__index = M

M.AVAIABLE_BACKEND = {
	linux = { "Vulkan", "Gl" },
	macos = { "Metal" },
	windows = { "Dx12", "Vulkan", "Gl" },
}

M.DEVICE_GPUS = wezterm.gui.enumerate_gpus()

function M:init()
	local adapter = {
		__avaiable_gpus = self.AVAIABLE_BACKEND[platform.os],
		__prefered_gpu = self.AVAIABLE_BACKEND[platform.os][1],
		options = {},
	}

	for _, g in ipairs(self.DEVICE_GPUS) do
		if not adapter.options[g.device_type] then
			adapter.options[g.device_type] = {}
		end

		adapter.options[g.device_type][g.backend] = g
	end

	setmetatable(adapter, M)
	return adapter
end

function M:pick_best()
	local gpu_options = self.options["DiscreteGpu"]
	    or self.options["IntegratedGpu"]
	    or self.options["Cpu"]
	    or self.options["Others"]

	if gpu_options == nil then
		wezterm.log_warn("No GPU adapters found. Using Default Adapter.")
		return
	end

	if gpu_options[self.__prefered_gpu] == nil then
		wezterm.log_warn("Preferred backend not available. Using Default Adapter.")
		return
	end

	return gpu_options[self.__prefered_gpu]
end

function M:pick_manual(device_type, backend)
	if self.options[device_type] == nil then
		wezterm.log_warn("No GPU adapters found. Using Default Adapter.")
		return
	end

	if self.options[device_type][backend] == nil then
		wezterm.log_warn("Preferred backend not available. Using Default Adapter.")
		return
	end

	return self.options[device_type][backend]
end

return M
