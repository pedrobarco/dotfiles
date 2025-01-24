local wezterm = require("wezterm")

local function is_windows()
	return wezterm.target_triple == "x86_64-pc-windows-msvc"
end

local config = wezterm.config_builder()
-- window settings
config.enable_tab_bar = false
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.window_close_confirmation = "NeverPrompt"

-- font settings
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 16

-- color settings
config.color_scheme = "gruvbox_material"
config.color_schemes = {
	["gruvbox_material"] = require("themes/gruvbox_material"),
}

if is_windows() then
	config.default_prog = { "ubuntu" }
end

return config
