-- Scout colorscheme palette
-- Based on Gruvbox colors from theme.json

local colors = {
  -- Base colors
  bg0 = "#1d2021",     -- Main background
  bg1 = "#3c3836",     -- Lighter background
  bg2 = "#504945",     -- Even lighter background
  bg3 = "#665c54",     -- Lightest background

  fg0 = "#ebdbb2",     -- Main foreground
  fg1 = "#d5c4a1",     -- Dimmer foreground
  fg2 = "#bdae93",     -- Even dimmer foreground
  fg3 = "#a89984",     -- Dimmest foreground

  -- Grays
  gray = "#928374",

  -- Syntax colors
  red = "#cc241d",
  bright_red = "#fb4934",

  green = "#98971a",
  bright_green = "#b8bb26",

  yellow = "#d79921",
  bright_yellow = "#fabd2f",

  blue = "#458588",
  bright_blue = "#83a598",

  purple = "#b16286",
  bright_purple = "#d3869b",

  aqua = "#689d6a",
  bright_aqua = "#8ec07c",

  orange = "#d65d0e",
  bright_orange = "#fe8019",

  -- UI specific colors
  fold_bg = "#252a28",   -- Very subtle fold background
  visual_bg = "#2f3f33",
  diff_add = "#3a3d21",
  diff_delete = "#462724",
  diff_change = "#504945",

  -- Special colors for highlights
  selection = "#689d6a",
  search = "#83a598",
  match = "#fe8019",

  none = "NONE",
}

return colors
