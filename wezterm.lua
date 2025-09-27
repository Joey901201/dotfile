local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- font
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14
config.adjust_window_size_when_changing_font_size = false

-- color scheme
config.color_scheme = 'Catppuccin Mocha'

-- tab bar
config.hide_tab_bar_if_only_one_tab = true


-- window
config.window_decorations = "RESIZE"
config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
}
config.window_close_confirmation = 'NeverPrompt'

-- maximize window on start
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- background
config.window_background_opacity = 0.6

-- misc
config.default_domain = 'WSL:Ubuntu'

-- F11 change mode
config.keys = {
  {
    key = "F11",
    mods = "",
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}

      if (overrides.window_background_opacity or config.window_background_opacity) < 1.0 then
        -- screenshot mode
        overrides.window_background_opacity = 1.0
        overrides.window_decorations = "RESIZE|TITLE"
      else
        -- normal mode
        overrides.window_background_opacity = 0.6
        overrides.window_decorations = "RESIZE"
      end

      window:set_config_overrides(overrides)
    end),
  }
}


return config