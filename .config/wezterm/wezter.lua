local wezterm = require 'wezterm';
return {
  font = wezterm.font("Ligamononoki Nerd Font"),
  font_size = 18.0,
  -- color_scheme = "Batman",
  -- color_scheme = "Lab Fox",
  -- color_scheme = "lovelace",
  color_scheme = "Dracula",
  scrollback_lines = 3500,
  enable_scroll_bar = true,
  default_cursor_style = 'BlinkingBar',
  hide_tab_bar_if_only_one_tab = true,
}
