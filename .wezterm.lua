-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font
-- config.font = wezterm.font 'JetBrainsMono Nerd Font'
-- config.font = wezterm.font 'IBM Plex Mono Regular'
config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font Mono',
  'BlexMono Nerd Font Mono',
}

-- Color scheme
config.color_scheme = 'Tokyo Night (Gogh)'


-- and finally, return the configuration to wezterm
return config
