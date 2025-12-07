return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		focus = true, -- Focus the trouble window when opened
		modes = {
			diagnostics = {
				mode = "diagnostics", -- Show diagnostics
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	},
}
