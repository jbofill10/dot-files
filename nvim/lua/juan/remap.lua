-- basic vim stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.completeopt = { "menuone", "noselect", "noinsert", "popup" }
vim.opt.cmdheight = 0

-- movement
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "search to bottom keep center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "search to top keep center" })
vim.keymap.set("n", "<C-j>", ":cnext<CR>zz", { desc = "Go to next on quickfix" })
vim.keymap.set("n", "<C-k>", ":cprev<CR>zz", { desc = "Go to next on quickfix" })
-- commenting
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
vim.keymap.set(
	"x",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment" }
)
-- git
vim.keymap.set("n", "[G", ":Gitsigns prev_hunk<CR>", { desc = "Go to previous git hunk" })
vim.keymap.set("n", "[g", ":Gitsigns next_hunk<CR>", { desc = "Go to previous git hunk" })
vim.keymap.set("n", "<C-w>g", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
vim.keymap.set("n", "<leader>gs", ":Neogit cwd=%:p:h kind=floating<CR>", { desc = "git status" })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
vim.keymap.set("n", "<leader>gb", ":Gitsigns setqflist target=attached<CR>", { desc = "Quickfix changes in file" })

-- vim.keymap.set("n", "<leader>g"

-- clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", function()
	require("telescope.builtin").lsp_references({ show_line = false })
end, { desc = "Go to references" })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- navigation
vim.keymap.set(
	"n",
	"<leader>e",
	":Neotree source=filesystem position=float toggle<CR>",
	{ desc = "Show file explorer" }
)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<C-p>", function()
	local file_dir = vim.fn.expand("%:p:h")
	-- Get the git root directory using rev-parse
	local git_root =
		vim.fn.system(string.format("cd %s && git rev-parse --show-toplevel", vim.fn.shellescape(file_dir)))

	-- Remove trailing newline
	git_root = string.gsub(git_root, "\n$", "")

	-- Use git_root if valid, otherwise fall back to file_dir
	local cwd = (vim.v.shell_error == 0 and git_root ~= "") and git_root or file_dir

	require("telescope.builtin").git_files({ cwd = cwd })
end, { desc = "git files" })

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })

vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
-- Additional copilot keymaps (Ctrl-based)
vim.keymap.set("i", "<C-i>", function()
	require("copilot.suggestion").accept()
end, { desc = "Accept Copilot suggestion" })
vim.keymap.set("i", "<C-s>", function()
	require("copilot.suggestion").next()
end, { desc = "Next Copilot suggestion" })
vim.keymap.set("i", "<C-h>", function()
	require("copilot.suggestion").prev()
end, { desc = "Previous Copilot suggestion" })
vim.keymap.set("i", "<C-\\>", function()
	require("copilot.suggestion").dismiss()
end, { desc = "Dismiss suggestion" })

-- harpoon
vim.keymap.set("n", "<leader>hx", function()
	require("harpoon"):list():add()
end, { desc = "Add current file to harpoon" })
vim.keymap.set("n", "<leader>hn", function()
	require("harpoon"):list():next()
end, { desc = "Go to next harpoon file" })
vim.keymap.set("n", "<leader>hp", function()
	require("harpoon"):list():prev()
end, { desc = "Go to prev harpoon file" })
vim.keymap.set("n", "<leader>hm", ":Telescope harpoon marks<CR>", { desc = "Show harpoon marks" })
-- auto-sessions
vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>sls", ":SessionSearch<CR>", { desc = "Session search" })

-- live-server
vim.keymap.set("n", "<leader>lt", ":LiveServerToggle .<CR>", { desc = "Toggle live server" })

-- folds
vim.keymap.set("n", "zp", function()
	local ufo = require("ufo")
	if not ufo then
		return vim.lsp.buf.hover()
	end

	local winid = pcall(function()
		return ufo.peekFoldedLinesUnderCursor()
	end)
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "Peek fold or show hover" })

-- ufo
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- generic langauge server stuff
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Show code actions" })
