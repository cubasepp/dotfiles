-- cubasepp WezTerm config -- installed to ~/.config/wezterm/ by configure/wezterm.sh
--
-- WezTerm puts this file's directory on package.path, so the modules beside it
-- are require-able by bare name. Each returns a table with an apply(config).
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("appearance").apply(config)
require("fonts").apply(config)
require("tabbar").apply(config)
require("keys").apply(config)
require("domains").apply(config)

-- registers a gui-startup handler; nothing to apply
require("startup")

return config
