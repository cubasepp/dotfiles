-- Hack Nerd Font Mono, matching config/kittyconf. Both faces are installed by
-- apps/11_font.sh (brew font-hack-nerd-font / font-caskaydia-mono-nerd-font).
--
-- The Mono variant is the right one for a terminal: its glyphs are boxed to a
-- single cell, so powerline separators and icons line up instead of overflowing.
local wezterm = require("wezterm")
local M = {}

-- Font size per display density.
--
-- The MacBook panel is ~254 ppi and renders at 2x; the iiyama ultrawide is
-- ~109 ppi and gets no HiDPI mode from macOS, so a glyph there has less than
-- half the pixels. At 12pt the stems land on ~1px and the tab pills in
-- tabbar.lua go visibly jaggy. Two extra points buys back the pixels.
M.HIDPI_FONT_SIZE = 12.0
M.LODPI_FONT_SIZE = 14.0

-- WezTerm on macOS reports DPI as 72 * backingScaleFactor, i.e. 144 on Retina
-- and 72 on a 1x panel -- not the physical ppi. 120 sits between those and also
-- splits the usual X11 pair (96 vs 192), so the same rule works on the pi.
local HIDPI_THRESHOLD = 120

-- Hinting. "Light" snaps stems to the pixel grid vertically only, which is what
-- keeps 14pt legible at 1x; at 2x there are enough pixels that the unhinted
-- "Normal" shape is the more faithful one.
local HIDPI_HINTING = "Normal"
local LODPI_HINTING = "Light"

local function overrides_for(dpi)
	if dpi and dpi < HIDPI_THRESHOLD then
		return M.LODPI_FONT_SIZE, LODPI_HINTING
	end
	return M.HIDPI_FONT_SIZE, HIDPI_HINTING
end

-- Whether a window's *effective* config is the low-DPI variant. tabbar.lua uses
-- this to pick its separators. Reading it back off the config rather than off a
-- module-level flag is what keeps it right per window: two windows on two
-- screens have two different effective configs, but would share one flag.
--
-- The midpoint comparison tolerates CMD +/- zoom, which scales the rendered
-- size without touching config.font_size.
function M.is_lodpi(conf)
	local size = conf and conf.font_size
	if not size then
		return false
	end
	return size > (M.HIDPI_FONT_SIZE + M.LODPI_FONT_SIZE) / 2
end

local function sync(window)
	-- The window can be gone by the time the event is handled (closing it while
	-- a resize is in flight), and get_dimensions() throws rather than returning
	-- nil in that case -- unguarded that kills the handler.
	local ok, dims = pcall(function()
		return window:get_dimensions()
	end)
	if not ok or not dims then
		return
	end

	local size, hinting = overrides_for(dims.dpi)
	local overrides = window:get_config_overrides() or {}

	-- Setting overrides re-fires window-config-reloaded, so bailing out when
	-- nothing changed is what keeps this from looping forever.
	if overrides.font_size == size and overrides.freetype_load_target == hinting then
		return
	end

	overrides.font_size = size
	overrides.freetype_load_target = hinting
	window:set_config_overrides(overrides)
end

-- update-status is the only one of these that reliably catches a window being
-- *dragged* to a screen with a different scale factor: WezTerm fires no event
-- for a plain move, so the timer is what closes the gap. It already runs once a
-- second for the status line (status_update_interval in tabbar.lua), and the
-- early return above makes the extra work a dimension read and a comparison.
wezterm.on("update-status", sync)
wezterm.on("window-config-reloaded", sync)
wezterm.on("window-resized", sync)

function M.apply(config)
	config.font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono", weight = "Regular" },
		{ family = "CaskaydiaMono Nerd Font" },
		{ family = "Symbols Nerd Font Mono" },
		"Apple Color Emoji",
	})

	-- Starting point only; sync() overrides both per window once the window
	-- exists and its DPI is known.
	config.font_size = M.HIDPI_FONT_SIZE
	config.freetype_load_target = HIDPI_HINTING
end

return M
