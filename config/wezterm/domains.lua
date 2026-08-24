-- Remote mux domains.
--
-- No `multiplexing` field means it defaults to "WezTerm": a wezterm-mux-server
-- runs on the remote host and keeps tabs alive across disconnects (tmux-style).
-- The protocol is version-sensitive, so both ends must be on the same WezTerm
-- release -- see apps/15_wezterm.sh, where the version is pinned.
--
-- Set multiplexing = "None" for a plain ssh session instead.
--
-- There is deliberately no local unix domain. One was tried, to let local panes
-- outlive the GUI, and it had to go: a pane on a mux domain is a *replica* that
-- the GUI paints from state synced over a socket, and the pinned 20240203 mux
-- client gets that sync wrong for partial repaints. Two symptoms, one cause --
-- fzf in --height mode (fzf-tab on Tab) painted one row per keystroke instead
-- of the whole list, and leaving a full-screen TUI like lazygit left the alt
-- screen stuck on display. Both are fine in a plain local pane, and fine in
-- kitty, which has no replication layer at all. Persistence on this machine is
-- not worth a terminal that mis-draws; on the pi it is, so the domain below
-- keeps it. If the pi ever shows the same drawing bugs, drop multiplexing there
-- too and run zellij or tmux on the far end instead.
local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	config.ssh_domains = {
		{
			name = "rasperry",
			remote_address = "192.168.178.37",
			username = "michi",
			ssh_option = {
				identityfile = wezterm.home_dir .. "/.ssh/mivo_id_ed25519",
			},

			-- Every client attaches to the one mux server the pi starts by
			-- default, so this is a *shared* session: a tab opened on the laptop
			-- shows up on the mac mini too, tmux-style. Accepted as a cosmetic
			-- annoyance -- it is the same property that keeps the tabs alive
			-- after the GUI goes away.
			--
			-- Uncommenting this makes each machine independent, at the cost of
			-- that persistence: tabs then die with the connection, so nothing
			-- long-running (a build, claude) survives closing the lid.
			-- multiplexing = "None",
			--
			-- Independent *and* persistent is not something WezTerm exposes as a
			-- setting. It is achievable, but only by hand: reach the pi through a
			-- unix domain whose proxy_command is
			--   ssh <host> "XDG_RUNTIME_DIR=/run/user/1000/wt-<client> \
			--     wezterm-mux-server --daemonize; exec nc -U .../wezterm/sock"
			-- keyed to wezterm.hostname(). Overriding socket_path alone is not
			-- enough -- the pid file is what refuses a second server, and it
			-- follows XDG_RUNTIME_DIR rather than the socket. Verified working,
			-- then dropped as not worth the moving parts.
		},
	}
end

return M
