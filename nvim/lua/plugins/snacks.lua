return {
	"folke/snacks.nvim",
	priority = 1000, -- Load before other plugins
	lazy = false, -- Load on startup, not lazy
	opts = {
		-- Enable terminal support (required for claudecode.nvim)
		terminal = { enabled = true },
		-- Optional: Enable other useful snacks features
		bigfile = { enabled = true },
		quickfile = { enabled = true },
	},
}
