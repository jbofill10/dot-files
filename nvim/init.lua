require("config")
require("juan")

vim.o.background = "dark" -- or "light" for light mode
vim.o.termguicolors = true -- Enable true color support
vim.g.everforest_background = "hard"

vim.cmd([[colorscheme kanagawa-dragon]])

-- Custom highlight overrides
vim.api.nvim_set_hl(0, "MiniCursorword", { bg = "#3C4045", underline = false })
