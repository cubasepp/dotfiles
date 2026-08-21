-- Catppuccin Mocha powerline tab bar + status line.
--
-- use_fancy_tab_bar = false is what allows real powerline separators and full
-- colour control; the cost is the native macOS tab strip. Note the status line
-- renders *inside* the tab bar, so hiding the bar hides the status line too.
local wezterm = require("wezterm")
local mocha = require("colors")

local M = {}

local ARROW = utf8.char(0xe0b0) -- right-pointing, for the tabs
local ARROW_LEFT = utf8.char(0xe0b2) -- left-pointing, for the status line

-- foreground process -> Nerd Font glyph
local process_icons = {
	zsh = utf8.char(0xf489),
	bash = utf8.char(0xf489),
	fish = utf8.char(0xf489),
	sh = utf8.char(0xf489),
	nvim = utf8.char(0xe62b),
	vim = utf8.char(0xe62b),
	node = utf8.char(0xe718),
	npm = utf8.char(0xe71e),
	python = utf8.char(0xe73c),
	python3 = utf8.char(0xe73c),
	cargo = utf8.char(0xe7a8),
	rustc = utf8.char(0xe7a8),
	go = utf8.char(0xe626),
	lua = utf8.char(0xe620),
	git = utf8.char(0xe702),
	lazygit = utf8.char(0xe702),
	docker = utf8.char(0xf308),
	lazydocker = utf8.char(0xf308),
	kubectl = utf8.char(0xf10fe),
	ssh = utf8.char(0xf0a0),
	claude = utf8.char(0xf0e7),
	btop = utf8.char(0xf085),
	htop = utf8.char(0xf085),
	top = utf8.char(0xf085),
	make = utf8.char(0xf085),
	psql = utf8.char(0xe76e),
	zellij = utf8.char(0xebc8),
	tmux = utf8.char(0xebc8),
	wezterm = utf8.char(0xf489),
}

local function basename(path)
	if not path then
		return nil
	end
	return path:match("([^/\\]+)$")
end

local function tab_icon(tab)
	local proc = basename(tab.active_pane.foreground_process_name)
	if proc then
		local icon = process_icons[proc]
		if icon then
			return icon
		end
	end
	return utf8.char(0xf489)
end

-- An explicit tab title (CMD+SHIFT+R rename) always wins over the pane title.
local function tab_label(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end
	local title = tab.active_pane.title
	if title and #title > 0 then
		return title
	end
	return basename(tab.active_pane.foreground_process_name) or "shell"
end

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local idx = tab.tab_index + 1
	local is_active = tab.is_active

	local bg, fg
	if is_active then
		bg, fg = mocha.mauve, mocha.crust
	elseif hover then
		bg, fg = mocha.surface1, mocha.text
	else
		bg, fg = mocha.surface0, mocha.subtext0
	end

	-- Colour of whatever follows, so the separator blends instead of notching.
	local next_bg = mocha.crust
	local next_tab = tabs[idx + 1]
	if next_tab then
		next_bg = next_tab.is_active and mocha.mauve or mocha.surface0
	end

	local marks = ""
	if tab.active_pane.is_zoomed then
		marks = marks .. " " .. utf8.char(0xf00e)
	end
	if not is_active and tab.active_pane.has_unseen_output then
		marks = marks .. " " .. utf8.char(0xf444)
	end

	local room = max_width - 8 - #marks
	if room < 4 then
		room = 4
	end
	local label = tab_label(tab)
	if #label > room then
		label = wezterm.truncate_right(label, room - 1) .. utf8.char(0x2026)
	end

	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Attribute = { Intensity = is_active and "Bold" or "Normal" } },
		{ Text = " " .. idx .. " " .. tab_icon(tab) .. " " .. label .. marks .. " " },
		{ Background = { Color = next_bg } },
		{ Foreground = { Color = bg } },
		{ Text = ARROW },
	}
end)

wezterm.on("update-status", function(window, pane)
	-- Left: workspace badge.
	window:set_left_status(wezterm.format({
		{ Background = { Color = mocha.mauve } },
		{ Foreground = { Color = mocha.crust } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = " " .. utf8.char(0xf120) .. " " .. window:active_workspace() .. " " },
		{ Background = { Color = mocha.crust } },
		{ Foreground = { Color = mocha.mauve } },
		{ Text = ARROW },
	}))

	local segs = {}

	-- cwd, with $HOME collapsed to ~
	local cwd = pane:get_current_working_dir()
	if cwd then
		local path
		if type(cwd) == "userdata" or type(cwd) == "table" then
			path = cwd.file_path
		end
		if not path then
			path = (tostring(cwd):gsub("^file://[^/]*", ""))
		end
		if path then
			local home = wezterm.home_dir
			if path:sub(1, #home) == home then
				path = "~" .. path:sub(#home + 1)
			end
			if #path > 1 and path:sub(-1) == "/" then
				path = path:sub(1, -2)
			end
			table.insert(segs, {
				icon = utf8.char(0xf07b),
				text = path,
				bg = mocha.sapphire,
				fg = mocha.crust,
			})
		end
	end

	-- battery
	for _, b in ipairs(wezterm.battery_info()) do
		local pct = b.state_of_charge * 100
		local icon, bg
		if b.state == "Charging" then
			icon, bg = utf8.char(0xf0e7), mocha.green
		elseif pct > 60 then
			icon, bg = utf8.char(0xf240), mocha.green
		elseif pct > 30 then
			icon, bg = utf8.char(0xf242), mocha.yellow
		else
			icon, bg = utf8.char(0xf244), mocha.red
		end
		table.insert(segs, {
			icon = icon,
			text = string.format("%.0f%%", pct),
			bg = bg,
			fg = mocha.crust,
		})
	end

	-- clock
	table.insert(segs, {
		icon = utf8.char(0xf017),
		text = wezterm.strftime("%H:%M"),
		bg = mocha.mauve,
		fg = mocha.crust,
	})

	local out = {}
	for i, seg in ipairs(segs) do
		local prev_bg = (i == 1) and mocha.crust or segs[i - 1].bg
		table.insert(out, { Background = { Color = prev_bg } })
		table.insert(out, { Foreground = { Color = seg.bg } })
		table.insert(out, { Text = ARROW_LEFT })
		table.insert(out, { Background = { Color = seg.bg } })
		table.insert(out, { Foreground = { Color = seg.fg } })
		table.insert(out, { Text = " " .. seg.icon .. " " .. seg.text .. " " })
	end
	window:set_right_status(wezterm.format(out))
end)

function M.apply(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = true
	config.tab_max_width = 32
	config.status_update_interval = 1000

	config.colors = {
		tab_bar = {
			background = mocha.crust,
			new_tab = { bg_color = mocha.crust, fg_color = mocha.overlay0 },
			new_tab_hover = { bg_color = mocha.surface0, fg_color = mocha.mauve },
		},
	}
end

return M
