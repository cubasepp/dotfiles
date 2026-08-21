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
	config.ssh_domains = {
		{
			name = "rasperry",
			remote_address = "192.168.178.37",
			username = "michi",
			ssh_option = {
				identityfile = wezterm.home_dir .. "/.ssh/mivo_id_ed25519",
			},
		},
	}
end

return M
