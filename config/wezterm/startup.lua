-- Centre the first window on the active screen at startup.
local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().active
	local _, _, mux_window = wezterm.mux.spawn_window(cmd or {})
	local window = mux_window:gui_window()
	local dimensions = window:get_dimensions()

	window:set_position(
		screen.x + math.floor((screen.width - dimensions.pixel_width) / 2),
		screen.y + math.floor((screen.height - dimensions.pixel_height) / 2)
	)
end)
