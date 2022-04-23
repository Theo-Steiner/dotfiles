local mapping = require("warped.default_mapping")
mapping["gruvboxdark"] = require("warped.utils").shallow_copy(mapping.default)
mapping.gruvboxdark.blue = "bright_magenta"
require("warped").setup({
	theme_config = function(Color, colors, Group, groups, styles)
		require("warped.default_theme_config")(Color, colors, Group, groups, styles)
		Group.new("CursorLine", colors.none, colors.none, styles.bold)
		Group.new("Folded", colors.none, colors.white)
	end,
	mapping = mapping,
})
