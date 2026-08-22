-- Remote mux domains.
--
-- No `multiplexing` field means it defaults to "WezTerm": a wezterm-mux-server
-- runs on the remote host and keeps tabs alive across disconnects (tmux-style).
-- The protocol is version-sensitive, so both ends must be on the same WezTerm
-- release -- see apps/15_wezterm.sh, where the version is pinned.
--
-- Set multiplexing = "None" for a plain ssh session instead.
local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	-- A local mux server, so local panes outlive the GUI: closing the window (or
	-- quitting the app) no longer kills what is running in them. Relaunching
	-- WezTerm reattaches. Same mechanism the pi already uses, applied locally.
	-- NB: "local" is a reserved built-in domain name and cannot be redefined.
	config.unix_domains = {
		{ name = "mux" },
	}
	config.default_domain = "mux"

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
