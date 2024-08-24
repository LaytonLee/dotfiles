local wezterm = require("wezterm")

local M = {}
M.__index = M

M.CYCLE_TIME = 30

math.randomseed(os.time())

function M:hi()
	print("hello wezterm")
end

function M:init()
	local handler = {
		idx = 0,
		files = {},
	}

	setmetatable(handler, M)
	wezterm.GLOBAL.background = nil

	return handler
end

function M:set_files(path)
	-- if path not give, use default background image directory: $HOME/.config/wezterm/backdrops
	local backdrop_dir = path or (wezterm.config_dir .. "/backdrops")

	self.files = wezterm.read_dir(backdrop_dir, function(filepath, meta)
		return {
			meta:is_file(),
			-meta:secs_since_created(), -- make the newest file at front
		}
	end)

	return self
end

function M:set_random()
	if self.files ~= nil then
		self.idx = math.random(#self.files)
		wezterm.GLOBAL.background = self.files[self.idx]
	end
end

function M:change_background(idx, files)
	if idx < 1 or idx > #files then
		return
	end

	idx = idx + 1
	wezterm.GLOBAL.background = files[idx]
	print("current idx: " .. idx)

	return idx
end

return M
