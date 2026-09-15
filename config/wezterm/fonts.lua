-- Hack Nerd Font Mono, matching config/kittyconf. Both faces are installed by
-- apps/11_font.sh (brew font-hack-nerd-font / font-caskaydia-mono-nerd-font).
--
-- The Mono variant is the right one for a terminal: its glyphs are boxed to a
-- single cell, so powerline separators and icons line up instead of overflowing.
local wezterm = require("wezterm")
local M = {}

-- Font size per display density.
--
-- The MacBook panel is ~254 ppi and renders at 2x; the 34" ultrawide is ~110 ppi
-- and gets no HiDPI mode from macOS, so a glyph there has less than half the
-- pixels. At 12pt the stems land on ~1px and the rounded tab pills in tabbar.lua
-- (which WezTerm draws as real curves) go visibly jaggy. Two extra points buys
-- back the pixels; it is not a cosmetic preference.
local HIDPI_FONT_SIZE = 12.0
local LODPI_FONT_SIZE = 14.0

-- WezTerm on macOS reports DPI as 72 * backingScaleFactor, i.e. 144 on Retina
-- and 72 on a 1x panel -- not the physical ppi. 120 sits between those and also
-- splits the usual X11 pair (96 vs 192), so the same rule works on the pi.
local HIDPI_THRESHOLD = 120

local function font_size_for(dpi)
	if dpi and dpi < HIDPI_THRESHOLD then
		return LODPI_FONT_SIZE
	end
	return HIDPI_FONT_SIZE
end

-- Dragging a window to a screen with a different scale factor re-lays out the
-- grid, which is what fires window-resized; window-config-reloaded covers the
-- first paint of a new window and every config reload.
local function sync_font_size(window)
	-- The window can be gone by the time the event is handled (closing it while
	-- a resize is in flight), and get_dimensions() throws rather than returning
	-- nil in that case -- unguarded that kills the handler.
	local ok, dims = pcall(function()
		return window:get_dimensions()
	end)
	if not ok or not dims then
		return
	end

	local size = font_size_for(dims.dpi)
	local overrides = window:get_config_overrides() or {}

	-- Setting overrides re-fires window-config-reloaded, so bailing out when the
	-- size already matches is what keeps this from looping forever.
	if overrides.font_size == size then
		return
	end

	overrides.font_size = size
	window:set_config_overrides(overrides)
end

wezterm.on("window-config-reloaded", sync_font_size)
wezterm.on("window-resized", sync_font_size)

function M.apply(config)
	config.font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono", weight = "Regular" },
		{ family = "CaskaydiaMono Nerd Font" },
		{ family = "Symbols Nerd Font Mono" },
		"Apple Color Emoji",
	})

	-- Starting point only; sync_font_size overrides it per window once the
	-- window exists and its DPI is known.
	config.font_size = HIDPI_FONT_SIZE
end

return M
