local wezterm = require("wezterm")

local M = {}
M.__index = M

function M:init()
	local keymaps = {}
	setmetatable(keymaps, M)

	-- Define the leader key
	keymaps.leader = {
		key = "a",
		mods = "CTRL",
		timeout_milliseconds = 2000,
	}

	keymaps.keys = {
		{
			key = "[",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
	}

	return keymaps
end

return M
