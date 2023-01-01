local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local custom_theme = require("lualine.themes.auto")
custom_theme.normal.c.bg = "dark"
custom_theme.insert.c.bg = "dark"
custom_theme.replace.c.bg = "dark"
custom_theme.visual.c.bg = "dark"
custom_theme.command.c.bg = "dark"

lualine.setup({
	options = {
		theme = custom_theme,
		section_separators = "",
		component_separators = "",
	},
})
