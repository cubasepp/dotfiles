-- Clickable paths and URLs.
--
-- eza already emits OSC 8 hyperlinks (--hyperlink in config/common/aliases.*),
-- so filenames in `ls` output carry a file:// URI. Handing those to macOS would
-- open Finder or some default app; this routes them to nvim instead, matching
-- the click-to-open-in-editor behaviour set up for kitty in af6ba38.
local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

wezterm.on("open-uri", function(window, pane, uri)
	local path = uri:match("^file://[^/]*(/.*)$")
	if not path then
		return true -- http(s) and everything else: let the OS handle it
	end

	-- percent-decode, then split a trailing :line[:col] off the end
	path = path:gsub("%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end)
	local file, line = path:match("^(.*):(%d+)$")
	file = file or path

	local cmd = "nvim "
	if line then
		cmd = cmd .. "+" .. line .. " "
	end
	cmd = cmd .. wezterm.shell_quote_arg(file)

	-- via a login shell so nvim is found on PATH (homebrew / ~/.local/bin)
	window:perform_action(act.SpawnCommandInNewTab({ args = { "sh", "-lc", cmd } }), pane)
	return false -- we handled it; do not also hand it to the OS
end)

function M.apply(config)
	-- start from the built-in rules rather than replacing them
	config.hyperlink_rules = wezterm.default_hyperlink_rules()

	config.mouse_bindings = {
		-- CMD-click opens the link under the cursor. The Down binding stops that
		-- click also being delivered to the program running in the pane.
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CMD",
			action = act.Nop,
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CMD",
			action = act.OpenLinkAtMouseCursor,
		},
	}
end

return M
