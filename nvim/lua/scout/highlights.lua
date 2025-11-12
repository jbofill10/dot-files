local M = {}

local function set_highlight(group, opts)
	local cmd = "highlight " .. group
	if opts.fg then
		cmd = cmd .. " guifg=" .. opts.fg
	end
	if opts.bg then
		cmd = cmd .. " guibg=" .. opts.bg
	end
	if opts.style then
		cmd = cmd .. " gui=" .. opts.style
	end
	if opts.sp then
		cmd = cmd .. " guisp=" .. opts.sp
	end
	if opts.link then
		cmd = "highlight! link " .. group .. " " .. opts.link
	end
	vim.cmd(cmd)
end

function M.setup(colors)
	-- Reset highlights
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Set colorscheme name and background
	vim.g.colors_name = "scout"
	vim.o.background = "dark"

	local highlights = {
		-- ============================================
		-- Standard Vim Syntax Groups
		-- ============================================
		Comment = { fg = colors.gray },
		Constant = { fg = colors.bright_purple },
		String = { fg = colors.bright_green },
		Character = { fg = colors.bright_green },
		Number = { fg = colors.bright_purple },
		Boolean = { fg = colors.bright_purple },
		Float = { fg = colors.bright_purple },

		Identifier = { fg = colors.bright_blue },
		Function = { fg = colors.bright_purple },

		Statement = { fg = colors.bright_red },
		Conditional = { fg = colors.bright_red },
		Repeat = { fg = colors.bright_red },
		Label = { fg = colors.bright_red },
		Operator = { fg = colors.bright_aqua },
		Keyword = { fg = colors.bright_red },
		Exception = { fg = colors.bright_red },

		PreProc = { fg = colors.bright_orange },
		Include = { fg = colors.bright_green },
		Define = { fg = colors.bright_orange },
		Macro = { fg = colors.bright_purple },
		PreCondit = { fg = colors.bright_orange },

		Type = { fg = colors.bright_yellow },
		StorageClass = { fg = colors.bright_orange },
		Structure = { fg = colors.bright_orange },
		Typedef = { fg = colors.bright_yellow },

		Special = { fg = colors.bright_orange },
		SpecialChar = { fg = colors.bright_red },
		Tag = { fg = colors.bright_aqua },
		Delimiter = { fg = colors.fg3 },
		SpecialComment = { fg = colors.gray, style = "italic" },
		Debug = { fg = colors.bright_red },

		Underlined = { style = "underline" },
		Ignore = { fg = colors.gray },
		Error = { fg = colors.bright_red },
		Todo = { fg = colors.bright_yellow, style = "bold" },

		-- ============================================
		-- UI Elements
		-- ============================================
		Normal = { fg = colors.fg0, bg = colors.bg0 },
		NormalFloat = { fg = colors.fg0, bg = colors.bg0 },
		FloatBorder = { fg = colors.bg1, bg = colors.bg0 },

		Cursor = { fg = colors.bg0, bg = colors.fg0 },
		CursorLine = { bg = colors.visual_bg },
		CursorColumn = { bg = colors.visual_bg },
		CursorLineNr = { fg = colors.bright_blue },

		LineNr = { fg = colors.bg3 },
		SignColumn = { bg = colors.bg0 },
		ColorColumn = { bg = colors.visual_bg },

		Visual = { bg = colors.visual_bg },
		VisualNOS = { bg = colors.visual_bg },

		Search = { bg = colors.search, fg = colors.bg0, style = "bold" },
		IncSearch = { bg = colors.bright_orange, fg = colors.bg0, style = "bold" },
		CurSearch = { bg = colors.bright_orange, fg = colors.bg0, style = "bold" },

		MatchParen = { bg = colors.gray, style = "bold" },

		Pmenu = { fg = colors.fg0, bg = colors.bg0 },
		PmenuSel = { fg = colors.bright_aqua, bg = colors.bg1, style = "bold" },
		PmenuSbar = { bg = colors.bg1 },
		PmenuThumb = { bg = colors.fg3 },

		StatusLine = { fg = colors.bg0, bg = colors.fg0 },
		StatusLineNC = { fg = colors.fg3, bg = colors.bg1 },

		TabLine = { fg = colors.fg3, bg = colors.bg0 },
		TabLineFill = { fg = colors.fg3, bg = colors.bg0 },
		TabLineSel = { fg = colors.fg0, bg = colors.bg1, style = "bold" },

		VertSplit = { fg = colors.bg1 },
		WinSeparator = { fg = colors.bg1 },

		Folded = { fg = colors.gray, bg = colors.fold_bg, style = "italic" },
		FoldColumn = { fg = colors.gray, bg = colors.bg0 },

		Directory = { fg = colors.bright_blue, style = "bold" },
		Title = { fg = colors.bright_yellow, style = "bold" },

		ErrorMsg = { fg = colors.bright_red, style = "bold" },
		WarningMsg = { fg = colors.bright_yellow, style = "bold" },
		Question = { fg = colors.bright_orange, style = "bold" },
		MoreMsg = { fg = colors.bright_aqua, style = "bold" },
		ModeMsg = { fg = colors.bright_yellow, style = "bold" },

		WildMenu = { fg = colors.bg0, bg = colors.fg0 },

		DiffAdd = { bg = colors.diff_add },
		DiffChange = { bg = colors.diff_change },
		DiffDelete = { bg = colors.diff_delete },
		DiffText = { bg = colors.diff_change, style = "bold" },

		SpellBad = { sp = colors.bright_red, style = "undercurl" },
		SpellCap = { sp = colors.bright_yellow, style = "undercurl" },
		SpellLocal = { sp = colors.bright_aqua, style = "undercurl" },
		SpellRare = { sp = colors.bright_purple, style = "undercurl" },

		-- ============================================
		-- Treesitter Highlights (@syntax)
		-- ============================================
		["@variable"] = { fg = colors.bright_blue },
		["@variable.builtin"] = { fg = colors.bright_purple },
		["@variable.parameter"] = { fg = colors.bright_blue },
		["@variable.member"] = { fg = colors.bright_blue },

		["@constant"] = { fg = colors.bright_purple },
		["@constant.builtin"] = { fg = colors.bright_purple },
		["@constant.macro"] = { fg = colors.bright_orange },

		["@module"] = { fg = colors.fg0 },
		["@label"] = { fg = colors.bright_red },

		["@string"] = { fg = colors.bright_green },
		["@string.regex"] = { fg = colors.bright_orange },
		["@string.escape"] = { fg = colors.bright_red },
		["@string.special"] = { fg = colors.bright_aqua },

		["@character"] = { fg = colors.bright_green },
		["@character.special"] = { fg = colors.bright_red },

		["@number"] = { fg = colors.bright_purple },
		["@number.float"] = { fg = colors.bright_purple },
		["@boolean"] = { fg = colors.bright_purple },

		["@function"] = { fg = colors.bright_purple },
		["@function.builtin"] = { fg = colors.bright_purple },
		["@function.macro"] = { fg = colors.bright_purple },
		["@function.method"] = { fg = colors.bright_purple },

		["@constructor"] = { fg = colors.bright_yellow },
		["@operator"] = { fg = colors.bright_aqua },

		["@keyword"] = { fg = colors.bright_red },
		["@keyword.function"] = { fg = colors.bright_red },
		["@keyword.operator"] = { fg = colors.bright_red },
		["@keyword.return"] = { fg = colors.bright_red },
		["@keyword.conditional"] = { fg = colors.bright_red },
		["@keyword.repeat"] = { fg = colors.bright_red },
		["@keyword.import"] = { fg = colors.bright_red },
		["@keyword.exception"] = { fg = colors.bright_red },

		["@type"] = { fg = colors.fg0 },
		["@type.builtin"] = { fg = colors.bright_yellow },
		["@type.builtin.go.special"] = { fg = colors.bright_red },
		["@type.definition"] = { fg = colors.fg0 },
		["@type.qualifier"] = { fg = colors.bright_orange },

		["@storageclass"] = { fg = colors.bright_orange },
		["@attribute"] = { fg = colors.bright_orange },
		["@field"] = { fg = colors.bright_purple },
		["@property"] = { fg = colors.bright_blue },

		["@comment"] = { link = "Comment" },
		["@comment.error"] = { fg = colors.bright_red, style = "bold" },
		["@comment.warning"] = { fg = colors.bright_yellow, style = "bold" },
		["@comment.note"] = { fg = colors.bright_blue, style = "bold" },
		["@comment.todo"] = { fg = colors.bright_yellow, style = "bold" },

		["@markup.strong"] = { style = "bold" },
		["@markup.italic"] = { style = "italic" },
		["@markup.underline"] = { style = "underline" },
		["@markup.strike"] = { style = "strikethrough" },
		["@markup.heading"] = { fg = colors.bright_orange, style = "bold" },
		["@markup.link"] = { fg = colors.bright_purple, style = "underline" },
		["@markup.link.url"] = { fg = colors.bright_blue, style = "underline" },
		["@markup.raw"] = { fg = colors.bright_aqua },
		["@markup.list"] = { fg = colors.bright_blue },
		["@markup.list.checked"] = { fg = colors.bright_green },
		["@markup.list.unchecked"] = { fg = colors.gray },

		["@tag"] = { fg = colors.bright_aqua },
		["@tag.attribute"] = { fg = colors.bright_yellow },
		["@tag.delimiter"] = { fg = colors.bright_blue },

		["@punctuation.delimiter"] = { fg = colors.fg3 },
		["@punctuation.bracket"] = { fg = colors.fg1 },
		["@punctuation.special"] = { fg = colors.bright_orange },

		-- ============================================
		-- LSP Semantic Tokens
		-- ============================================
		["@lsp.type.class"] = { fg = colors.bright_yellow },
		["@lsp.type.decorator"] = { fg = colors.bright_orange },
		["@lsp.type.enum"] = { fg = colors.bright_yellow },
		["@lsp.type.enumMember"] = { fg = colors.bright_purple },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.interface"] = { fg = colors.bright_yellow },
		["@lsp.type.macro"] = { fg = colors.bright_orange },
		["@lsp.type.method"] = { link = "@function.method" },
		["@lsp.type.namespace"] = { fg = colors.fg0 },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { fg = colors.bright_yellow },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.typeParameter"] = { fg = colors.bright_yellow },
		["@lsp.type.variable"] = { link = "@variable" },

		-- ============================================
		-- LSP Diagnostics
		-- ============================================
		DiagnosticError = { fg = colors.bright_red },
		DiagnosticWarn = { fg = colors.bright_yellow },
		DiagnosticInfo = { fg = colors.bright_blue },
		DiagnosticHint = { fg = colors.bright_aqua },
		DiagnosticOk = { fg = colors.bright_green },

		DiagnosticSignError = { fg = colors.bright_red, bg = colors.bg0 },
		DiagnosticSignWarn = { fg = colors.bright_yellow, bg = colors.bg0 },
		DiagnosticSignInfo = { fg = colors.bright_blue, bg = colors.bg0 },
		DiagnosticSignHint = { fg = colors.bright_aqua, bg = colors.bg0 },
		DiagnosticSignOk = { fg = colors.bright_green, bg = colors.bg0 },

		DiagnosticUnderlineError = { sp = colors.bright_red, style = "undercurl" },
		DiagnosticUnderlineWarn = { sp = colors.bright_yellow, style = "undercurl" },
		DiagnosticUnderlineInfo = { sp = colors.bright_blue, style = "undercurl" },
		DiagnosticUnderlineHint = { sp = colors.bright_aqua, style = "undercurl" },
		DiagnosticUnderlineOk = { sp = colors.bright_green, style = "undercurl" },

		DiagnosticVirtualTextError = { fg = colors.bright_red, bg = colors.bg0 },
		DiagnosticVirtualTextWarn = { fg = colors.bright_yellow, bg = colors.bg0 },
		DiagnosticVirtualTextInfo = { fg = colors.bright_blue, bg = colors.bg0 },
		DiagnosticVirtualTextHint = { fg = colors.bright_aqua, bg = colors.bg0 },

		-- ============================================
		-- Git Signs
		-- ============================================
		GitSignsAdd = { fg = colors.bright_green },
		GitSignsChange = { fg = colors.bright_blue },
		GitSignsDelete = { fg = colors.bright_red },

		-- ============================================
		-- Indent Blankline
		-- ============================================
		IblIndent = { fg = colors.bg3 },
		IblScope = { fg = colors.bright_aqua, style = "bold" },
		IblWhitespace = { fg = colors.bg2 },

		-- ============================================
		-- Telescope
		-- ============================================
		TelescopeNormal = { link = "Normal" },
		TelescopeBorder = { fg = colors.bg1 },
		TelescopePromptBorder = { fg = colors.bg1 },
		TelescopeResultsBorder = { fg = colors.bg1 },
		TelescopePreviewBorder = { fg = colors.bg1 },
		TelescopeSelection = { fg = colors.bright_aqua, bg = colors.bg1, style = "bold" },
		TelescopeSelectionCaret = { fg = colors.bright_aqua },
		TelescopeMatching = { fg = colors.bright_yellow, style = "bold" },

		-- ============================================
		-- Rainbow Delimiters
		-- ============================================
		RainbowDelimiterPink = { fg = colors.bright_purple },
		RainbowDelimiterBlue = { fg = colors.blue },
		RainbowDelimiterCyan = { fg = colors.bright_aqua },
		RainbowDelimiterViolet = { fg = colors.purple },
		RainbowDelimiterOrange = { fg = colors.bright_orange },
		RainbowDelimiterRed = { fg = colors.bright_red },

		-- ============================================
		-- Terminal Colors
		-- ============================================
	}

	-- Apply all highlights
	for group, opts in pairs(highlights) do
		set_highlight(group, opts)
	end

	-- Set terminal colors
	vim.g.terminal_color_0 = colors.bg1
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.yellow
	vim.g.terminal_color_4 = colors.blue
	vim.g.terminal_color_5 = colors.purple
	vim.g.terminal_color_6 = colors.aqua
	vim.g.terminal_color_7 = colors.fg3

	vim.g.terminal_color_8 = colors.gray
	vim.g.terminal_color_9 = colors.bright_red
	vim.g.terminal_color_10 = colors.bright_green
	vim.g.terminal_color_11 = colors.bright_yellow
	vim.g.terminal_color_12 = colors.bright_blue
	vim.g.terminal_color_13 = colors.bright_purple
	vim.g.terminal_color_14 = colors.bright_aqua
	vim.g.terminal_color_15 = colors.fg0
end

return M
