local config = require("config")

-- loading background images
require("utils.backdrop"):init():set_files():set_random()

return config:init()
	:append(require("appearance"):init()).options
