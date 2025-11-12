-- Configure diagnostic display
vim.diagnostic.config({
	-- Disable inline virtual text (only show icons in gutter)
	virtual_text = false,

	-- Show signs in the gutter/sign column with custom icons
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},

	-- Underline diagnostic issues with more prominence
	underline = true,

	-- Update diagnostics while in insert mode
	update_in_insert = false,

	-- Sort diagnostics by severity (ERROR first, then WARN, INFO, HINT)
	severity_sort = true,

	-- Configure floating window for diagnostics
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always", -- Show source in float window
		header = "",
		prefix = "",
	},
})

-- Enhance diagnostic visibility with background colors
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#db4b4b", bg = "#3c2626" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#FFD700", bg = "#3a3326" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#0db9d7", bg = "#263342" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#1abc9c", bg = "#263332" })
