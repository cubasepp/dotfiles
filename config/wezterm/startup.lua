-- Centre the first window on the active screen at startup.
local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
	-- With a unix mux domain, launching WezTerm may reattach to a session that
	-- already has windows. Spawning unconditionally would add a second one, so
	-- reuse what is there.
	local mux_window
	local existing = wezterm.mux.all_windows()
	if #existing > 0 then
		mux_window = existing[1]
	else
		local _, _, spawned = wezterm.mux.spawn_window(cmd or {})
		mux_window = spawned
	end

	local window = mux_window and mux_window:gui_window()
	if not window then
		return
	end

	local screen = wezterm.gui.screens().active
	local dimensions = window:get_dimensions()

	window:set_position(
		screen.x + math.floor((screen.width - dimensions.pixel_width) / 2),
		screen.y + math.floor((screen.height - dimensions.pixel_height) / 2)
	)
end)
