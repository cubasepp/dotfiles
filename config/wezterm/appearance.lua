-- Colour scheme, transparency and initial window size.
local M = {}

function M.apply(config)
	config.color_scheme = "Catppuccin Mocha"
	config.window_background_opacity = 0.85
	config.macos_window_background_blur = 20

	-- Silence the "bing" on \a (bell) -- e.g. shell tab-completion errors, or a
	-- long-running remote command finishing. Visual bell is off too (no flash).
	config.audible_bell = "Disabled"
	config.visual_bell = { fade_in_duration_ms = 0, fade_out_duration_ms = 0 }

	config.initial_cols = 200
	config.initial_rows = 50

	-- Default is 3500, which is not much when searching back through build
	-- output. Costs a few MB of RAM per pane.
	config.scrollback_lines = 20000

	-- Name the initial workspace. CMD+SHIFT+E renames at runtime, but that dies
	-- with the process; this is what makes it stick across restarts.
	config.default_workspace = "home"
end

return M
