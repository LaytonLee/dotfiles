local wezterm = require("wezterm")

local M = {}
M.__index = M

function M:init()
	local config = setmetatable({ options = {} }, M)

	return config
end

function M:append(options)
	for k, v in pairs(options) do
		if self.options[k] ~= nil then
			wezterm.log_warn("option already exists: ", { old = self.options[k], new = options.k })
		end

		self.options[k] = v
	end

	return self
end

return M
