-- Key bindings, on top of WezTerm's defaults.
--
-- CTRL+SHIFT+Space (QuickSelect) is a WezTerm default that macOS steals for its
-- input-source switcher; configure/wezterm.sh disables the offending system
-- hotkeys so it actually reaches the terminal.
local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.apply(config)
	config.keys = {
		-- ---- panes ----
		{
			key = "d",
			mods = "CMD",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "d",
			mods = "CMD|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		-- ---- tabs ----
		{
			key = "r",
			mods = "CMD|SHIFT",
			action = act.PromptInputLine({
				description = "Rename tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "p",
			mods = "CMD",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|TABS",
				title = "Select tab",
			}),
		},

		{
			-- overlay a letter on every pane; type it to focus that pane
			key = "s",
			mods = "CMD|SHIFT",
			action = act.PaneSelect({ alphabet = "asdfghjkl" }),
		},

		-- ---- scrolling ----
		-- Shift+PageUp/PageDown are bound by default, but MacBooks have no PageUp or
		-- PageDown key (they are Fn+Shift+Arrow), and nothing scrolls line-by-line.
		{ key = "UpArrow", mods = "CMD|SHIFT", action = act.ScrollByLine(-1) },
		{ key = "DownArrow", mods = "CMD|SHIFT", action = act.ScrollByLine(1) },
		{ key = "UpArrow", mods = "CMD|ALT", action = act.ScrollByPage(-0.5) },
		{ key = "DownArrow", mods = "CMD|ALT", action = act.ScrollByPage(0.5) },
		{ key = "Home", mods = "CMD", action = act.ScrollToTop },
		{ key = "End", mods = "CMD", action = act.ScrollToBottom },

		-- ---- workspaces ----
		{
			key = "p",
			mods = "CMD|SHIFT",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES",
				title = "Select workspace",
			}),
		},
		{
			key = "n",
			mods = "CMD|SHIFT",
			action = act.PromptInputLine({
				description = "New workspace name",
				action = wezterm.action_callback(function(window, pane, line)
					if line and #line > 0 then
						window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
					end
				end),
			}),
		},
		{
			key = "e",
			mods = "CMD|SHIFT",
			action = act.PromptInputLine({
				description = "Rename workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line and #line > 0 then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		{ key = "RightArrow", mods = "CMD|ALT", action = act.SwitchWorkspaceRelative(1) },
		{ key = "LeftArrow", mods = "CMD|ALT", action = act.SwitchWorkspaceRelative(-1) },

		-- ---- remote domains ----
		{
			-- new tab on the pi, in the current window
			key = "i",
			mods = "CMD|SHIFT",
			action = act.SpawnCommandInNewTab({ domain = { DomainName = "rasperry" } }),
		},
		{
			-- new tab back on this machine, even from inside a remote domain pane --
			-- CMD+T alone spawns in CurrentPaneDomain, which just re-connects
			key = "l",
			mods = "CMD|SHIFT",
			action = act.SpawnCommandInNewTab({ domain = { DomainName = "local" } }),
		},
		{
			key = "o",
			mods = "CMD|SHIFT",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|DOMAINS",
				title = "Select domain",
			}),
		},

		-- ---- quick select ----
		{
			-- label every non-whitespace run; typing its letters inserts the text
			key = "phys:Space",
			mods = "CTRL|SHIFT",
			action = act.QuickSelectArgs({
				label = "insert path",
				-- Curated instead of [^\\s]+ : that matched every word on screen, which
				-- buried the thing you actually wanted under a wall of labels.
				patterns = {
					[==[\b[0-9a-f]{7,40}\b]==], -- git SHAs
					[==[\b\d{1,3}(\.\d{1,3}){3}\b]==], -- IPv4
					[==[\b[a-zA-Z][\w+.-]*://\S+]==], -- URLs
					[==[[.~]?/[-\w.~/@+]+]==], -- paths
					[==[[-\w./~]+:\d+(:\d+)?]==], -- path:line[:col]
					[==["[^"]{2,}"]==], -- quoted strings
				},
				action = wezterm.action_callback(function(window, pane)
					local path = window:get_selection_text_for_pane(pane)
					if path and #path > 0 then
						pane:send_text(wezterm.shell_quote_arg(path))
					end
				end),
			}),
		},
	}
end

return M
