-- This module contains a number of default definitions
local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
	},
	query = {
		[""] = "rainbow-delimiters",
	},
	highlight = {
		"RainbowDelimiterPink",
		"RainbowDelimiterBlue",
		"RainbowDelimiterCyan",
		"RainbowDelimiterViolet",
		"RainbowDelimiterOrange",
		"RainbowDelimiterRed",
	},
	max_file_lines = 3000,
}
