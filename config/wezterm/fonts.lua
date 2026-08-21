-- Hack Nerd Font Mono, matching config/kittyconf. Both faces are installed by
-- apps/11_font.sh (brew font-hack-nerd-font / font-caskaydia-mono-nerd-font).
--
-- The Mono variant is the right one for a terminal: its glyphs are boxed to a
-- single cell, so powerline separators and icons line up instead of overflowing.
local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	config.font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono", weight = "Regular" },
		{ family = "CaskaydiaMono Nerd Font" },
		{ family = "Symbols Nerd Font Mono" },
		"Apple Color Emoji",
	})
	config.font_size = 12.0
end

return M
