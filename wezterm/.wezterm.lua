local wezterm = require 'wezterm'
local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Set PowerShell as the default program
  config.default_prog = { 'powershell.exe', '-NoLogo' }
end

config.font = wezterm.font("JetBrains Mono", {weight="Medium"})
config.font_size = 12.0  -- Adjust the font size as needed

-- Define the color scheme
config.color_scheme = "gruvbox_material_dark_hard"

-- Define the color schemes
config.color_schemes = {
    ["gruvbox_material_dark_hard"] = {
        foreground = "#D4BE98",
        background = "#1D2021",
        cursor_bg = "#D4BE98",
        cursor_border = "#D4BE98",
        cursor_fg = "#1D2021",
        selection_bg = "#D4BE98",
        selection_fg = "#3C3836",

        ansi = {
            "#1d2021", "#ea6962", "#a9b665", "#d8a657",
            "#7daea3", "#d3869b", "#89b482", "#d4be98"
        },
        brights = {
            "#eddeb5", "#ea6962", "#a9b665", "#d8a657",
            "#7daea3", "#d3869b", "#89b482", "#d4be98"
        },
    }
}

return config
