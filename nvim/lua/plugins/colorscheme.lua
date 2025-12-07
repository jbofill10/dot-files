return {
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{ "luisiacc/gruvbox-baby" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	{ "sainnhe/everforest" },
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				overrides = function(colors)
					local theme = colors.theme
					return {
						LineNr = { bg = theme.ui.bg },
						CursorLineNr = { bg = theme.ui.bg },
						SignColumn = { bg = theme.ui.bg },
						DiagnosticSignError = { bg = "NONE" },
						DiagnosticSignWarn = { bg = "NONE" },
						DiagnosticSignInfo = { bg = "NONE" },
						DiagnosticSignHint = { bg = "NONE" },
						GitSignsAdd = { bg = "NONE" },
						GitSignsChange = { bg = "NONE" },
						GitSignsDelete = { bg = "NONE" },
					}
				end,
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
			})
		end,
	},
	{ "shaunsingh/nord.nvim" },
	{ "marko-cerovac/material.nvim" },
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
}
