-- basic vim stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without yanking" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "search to bottom keep center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "search to top keep center" })
vim.keymap.set("n", "<M-j>", ":cnext<CR>", { desc = "Go to next on quickfix" })
vim.keymap.set("n", "<M-k>", ":cprev<CR>", { desc = "Go to next on quickfix" })

-- navigation
vim.keymap.set("n", "<leader>ee", ":Neotree source=filesystem position=float toggle<CR>", { desc = "Show file explorer" })
vim.keymap.set("n", "<leader>eb", ":Telescope buffers<CR>", { desc = "Show open files" })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<C-p>', function()
    local file_dir = vim.fn.expand('%:p:h')
    -- Get the git root directory using rev-parse
    local git_root = vim.fn.system(string.format('cd %s && git rev-parse --show-toplevel', vim.fn.shellescape(file_dir)))

    -- Remove trailing newline
    git_root = string.gsub(git_root, '\n$', '')

    -- Use git_root if valid, otherwise fall back to file_dir
    local cwd = (vim.v.shell_error == 0 and git_root ~= '') and git_root or file_dir

    require('telescope.builtin').git_files({ cwd = cwd })
end, { desc = "git files" })



-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })

-- copilot
vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.keymap.set('n', '<leader>cc', ':CopilotChatToggle<CR>', { desc = "Toggle Copilot chat" })
vim.keymap.set('n', '<leader>cs', ':CopilotChatStop<CR>', { desc = "Stop Copilot response" })
vim.keymap.set('n', '<leader>cr', ':CopilotChatReset<CR>', { desc = "Reset Copilot Chat" })
vim.keymap.set('n', '<leader>cm', ':CopilotChatModels<CR>', { desc = "Set Copilot model" })
-- harpoon
vim.keymap.set('n', '<leader>hx', function() require("harpoon"):list():add() end,
    { desc = "Add current file to harpoon" })
vim.keymap.set('n', '<leader>hn', function() require("harpoon"):list():next() end, { desc = "Go to next harpoon file" })
vim.keymap.set('n', '<leader>hp', function() require("harpoon"):list():prev() end, { desc = "Go to prev harpoon file" })
vim.keymap.set('n', '<leader>hm', ':Telescope harpoon marks<CR>', { desc = "Show harpoon marks" })

-- auto-sessions
vim.keymap.set('n', '<leader>ss', ':SessionSave<CR>', { desc = "Save session" })
vim.keymap.set('n', '<leader>sls', ':SessionSearch<CR>', { desc = "Session search" })

-- live-server
vim.keymap.set('n', '<leader>lt', ':LiveServerToggle .<CR>', { desc = "Toggle live server" })

-- folds
vim.keymap.set("n", "zp", function()
    local ufo = require("ufo")
    if not ufo then return vim.lsp.buf.hover() end

    local winid = pcall(function() return ufo.peekFoldedLinesUnderCursor() end)
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = "Peek fold or show hover" })

-- git
vim.keymap.set('n', '<leader>gs', function()
    local file_dir = vim.fn.expand('%:p:h')
    -- You could store the original cwd to restore it later if needed
    local original_cwd = vim.fn.getcwd()
    vim.cmd('Neogit cwd=' .. file_dir .. ' kind=floating')
    -- Restore original cwd if necessary
    vim.cmd('cd ' .. original_cwd)
end, { desc = "git status (file repo)" })

vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = "show inline blame" })
vim.keymap.set('n', '<leader>gi', ':Gitsigns preview_hunk<CR>', { desc = "show diff popup" })

-- ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- java
vim.keymap.set('n', '<leader>jrm', ':JavaTestRunCurrentMethod<CR>', { desc = "Run current method" })
vim.keymap.set('n', '<leader>jrc', ':JavaTestRunCurrentClass<CR>', { desc = "Run current method" })

-- generic langauge server stuff
vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { desc = "Show code actions" })
