local wezterm = require("wezterm")

local function is_windows()
	return wezterm.target_triple == "x86_64-pc-windows-msvc"
end

local function is_mac()
	return wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin"
end

local function color_scheme(appearance, colors)
	if appearance:find("Light") then
		return colors.light
	end
	return colors.dark
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
config.font_size = 14
-- config.line_height = 1.3
-- config.cell_width = 1.02

-- color settings
config.color_schemes = {
	["gruvbox_material"] = require("themes/gruvbox_material"),
	["oldtale"] = require("themes/oldtale"),
	["melange_dark"] = require("themes/melange_dark"),
	["neosolarized_dark"] = require("themes/neosolarized_dark"),
	["neosolarized_light"] = require("themes/neosolarized_light"),
}
config.color_scheme = color_scheme(wezterm.gui.get_appearance(), {
	dark = "neosolarized_light",
	light = "neosolarized_light",
})

if is_windows() then
	config.default_prog = { "ubuntu" }
end

if is_mac() then
	config.font = wezterm.font({
		family = "Monaco",
	})
	config.font_size = 16
end

return config
