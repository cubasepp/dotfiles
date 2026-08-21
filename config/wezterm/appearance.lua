-- Colour scheme, transparency and initial window size.
local M = {}

function M.apply(config)
	config.color_scheme = "Catppuccin Mocha"
	config.window_background_opacity = 0.85
	config.macos_window_background_blur = 20

	config.initial_cols = 200
	config.initial_rows = 50

	-- Name the initial workspace. CMD+SHIFT+E renames at runtime, but that dies
	-- with the process; this is what makes it stick across restarts.
	config.default_workspace = "home"
end

return M
