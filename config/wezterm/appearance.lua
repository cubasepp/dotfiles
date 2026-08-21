-- Colour scheme, transparency and initial window size.
local M = {}

function M.apply(config)
	config.color_scheme = "Catppuccin Mocha"
	config.window_background_opacity = 0.85
	config.macos_window_background_blur = 20

	config.initial_cols = 200
	config.initial_rows = 50
end

return M
