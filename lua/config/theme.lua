-- 主题颜色配置
-- 使用方式: local theme = require('config.theme')
--         local colors = theme.catppuccin
--         vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.dark_text_1 })

local M = {}

-- Catppuccin Mocha 主题
M.catppuccin = {
  -- 基础背景色
  base = '#1e1e2e',
  mantle = '#181825',
  crust = '#11111b',

  -- 文本颜色（从深到浅）
  dark_text_4 = '#45475a',
  dark_text_3 = '#585b70',
  dark_text_2 = '#6c7086',
  dark_text_1 = '#a6adc8',
  light_text_1 = '#bac2de',
  light_text_2 = '#cdd6f4',
  light_text_3 = '#dce0e8',

  -- 主题色
  rosewater = '#f5e0dc',
  flamingo = '#f2cdcd',
  pink = '#f5c2e7',
  mauve = '#cba6f7',
  red = '#f38ba8',
  maroon = '#eba0ac',
  peach = '#fab387',
  yellow = '#f9e2af',
  green = '#a6e3a1',
  teal = '#94e2d5',
  sky = '#89dceb',
  sapphire = '#74c7ec',
  blue = '#89b4fa',
  lavender = '#b4befe',

  -- 覆盖层
  surface0 = '#313244',
  surface1 = '#45475a',
  surface2 = '#585b70',

  -- 边框
  overlay0 = '#6c7086',
  overlay1 = '#7f849c',
  overlay2 = '#9399b2',

  -- 状态栏颜色
  error = '#f38ba8',
  warning = '#fab387',
  info = '#89b4fa',
  success = '#a6e3a1',
}

-- Catppuccin Latte 主题（浅色）
M.catppuccin_latte = {
  -- 基础背景色
  base = '#eff1f5',
  mantle = '#e6e9ef',
  crust = '#dce0e8',

  -- 文本颜色
  dark_text_4 = '#9ca0b0',
  dark_text_3 = '#7f7e8c',
  dark_text_2 = '#5c5f77',
  dark_text_1 = '#4c4f69',
  light_text_1 = '#5c5f77',
  light_text_2 = '#6c6f85',
  light_text_3 = '#7c7f93',

  -- 主题色
  rosewater = '#dc8a78',
  flamingo = '#dd7878',
  pink = '#ea76cb',
  mauve = '#8839ef',
  red = '#d20f39',
  maroon = '#e64553',
  peach = '#fe640b',
  yellow = '#df8e1d',
  green = '#40a02b',
  teal = '#179299',
  sky = '#04a5e5',
  sapphire = '#209fb5',
  blue = '#1e66f5',
  lavender = '#7287fd',

  -- 覆盖层
  surface0 = '#ccd0da',
  surface1 = '#bcc0cc',
  surface2 = '#acb0be',

  -- 边框
  overlay0 = '#7c7f93',
  overlay1 = '#8c8fa1',
  overlay2 = '#9ca0af',

  -- 状态栏颜色
  error = '#d20f39',
  warning = '#fe640b',
  info = '#1e66f5',
  success = '#40a02b',
}

-- Gruvbox 主题
M.gruvbox = {
  -- 基础背景色
  base = '#282828',
  mantle = '#1d2021',
  crust = '#0d0d0d',

  -- 文本颜色
  dark_text_4 = '#504945',
  dark_text_3 = '#665c54',
  dark_text_2 = '#a89984',
  dark_text_1 = '#d5c4a1',
  light_text_1 = '#ebdbb2',
  light_text_2 = '#f5f0c6',
  light_text_3 = '#fbf1c7',

  -- 主题色
  rosewater = '#d79921',
  flamingo = '#fb4934',
  pink = '#b16286',
  mauve = '#d3869b',
  red = '#fb4934',
  maroon = '#cc241d',
  peach = '#fe8019',
  yellow = '#fabd2f',
  green = '#b8bb26',
  teal = '#8ec07c',
  sky = '#83a598',
  sapphire = '#458588',
  blue = '#83a598',
  lavender = '#b16286',

  -- 覆盖层
  surface0 = '#3c3836',
  surface1 = '#504945',
  surface2 = '#665c54',

  -- 边框
  overlay0 = '#a89984',
  overlay1 = '#928374',
  overlay2 = '#7c6f64',

  -- 状态栏颜色
  error = '#fb4934',
  warning = '#fe8019',
  info = '#83a598',
  success = '#b8bb26',
}

-- Tokyo Night 主题
M.tokyo_night = {
  -- 基础背景色
  base = '#1a1b26',
  mantle = '#16161e',
  crust = '#0f0f14',

  -- 文本颜色
  dark_text_4 = '#414868',
  dark_text_3 = '#565f89',
  dark_text_2 = '#737aa2',
  dark_text_1 = '#a9b1d6',
  light_text_1 = '#c0caf5',
  light_text_2 = '#bb9af7',
  light_text_3 = '#c0c8f0',

  -- 主题色
  rosewater = '#f7768e',
  flamingo = '#ff9e64',
  pink = '#db4b4b',
  mauve = '#9d7cd8',
  red = '#f7768e',
  maroon = '#db4b4b',
  peach = '#ff9e64',
  yellow = '#e0af68',
  green = '#9ece6a',
  teal = '#73daca',
  sky = '#7aa2f7',
  sapphire = '#7dcfff',
  blue = '#7aa2f7',
  lavender = '#bb9af7',

  -- 覆盖层
  surface0 = '#24283b',
  surface1 = '#292e42',
  surface2 = '#414868',

  -- 边框
  overlay0 = '#737aa2',
  overlay1 = '#7aa2f7',
  overlay2 = '#7dcfff',

  -- 状态栏颜色
  error = '#f7768e',
  warning = '#e0af68',
  info = '#7aa2f7',
  success = '#9ece6a',
}

return M
