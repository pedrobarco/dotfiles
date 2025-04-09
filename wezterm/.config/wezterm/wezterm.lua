local wezterm = require("wezterm")

local function is_windows()
	return wezterm.target_triple == "x86_64-pc-windows-msvc"
end

local function is_mac()
	return wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin"
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
	family = "JetBrainsMonoNL Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 14
config.line_height = 1.3
config.cell_width = 1.02

-- color settings
config.color_scheme = "oldtale"
config.color_schemes = {
	["gruvbox_material"] = require("themes/gruvbox_material"),
	["oldtale"] = require("themes/oldtale"),
}

if is_windows() then
	config.default_prog = { "ubuntu" }
end

if is_mac() then
	config.font_size = 18
end

return config
