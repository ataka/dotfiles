-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ホット・リロード
config.automatically_reload_config = true

-- 日本語入力 OK
config.use_ime = true

-- FPS (Default: 60)
config.max_fps = 120

-- フォント
-- config.font = wezterm.font("UDEV Gothic NFLG", {weight="Regular", stretch="Normal", style="Normal"})

config.font = wezterm.font_with_fallback {
  {
    family = 'UDEV Gothic NFLG',
    weight = 'Regular',
    stretch = "Normal",
    style = "Normal",
  },
  'Noto Color Emoji',
}

config.font_size = 12.0

-- テーマ
config.color_scheme = 'Catppuccin Frappe'

-- 背景の透過
local opacity_active = 0.90
local opacity_inactive = 0.80
config.window_background_opacity = opacity_inactive
config.macos_window_background_blur = 5

wezterm.on('window-focus-changed', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if window:is_focused() then
    overrides.window_background_opacity = opacity_active
  else
    overrides.window_background_opacity = opacity_inactive
  end
  window:set_config_overrides(overrides)
end)

-- タブバー
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブバーを下に配置する
config.tab_bar_at_bottom = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
-- config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_lower_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#414559" -- catppuccin.frappe.surface0
  local foreground = "#c6d0f5" -- catppuccin.frappe.text
  local edge_background = "none"
  if tab.is_active then
    background = "#e5c890" -- catppuccin.frappe.yellow
    foreground = "#232634" -- catppuccin.frappe.crust
  end
  local edge_foreground = background

  local title = "   " .. tab.tab_index .. ": " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- キー設定を読み込む
-- ============================================================
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- デフォルトのキーバインドを無効にする
config.disable_default_key_bindings = true

-- Leaderキーを設定する
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

-- Return configuration
return config
