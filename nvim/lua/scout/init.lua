-- Scout colorscheme
-- A Gruvbox-inspired colorscheme for Neovim

local M = {}

function M.load()
  -- Load color palette
  local colors = require("scout.colors")

  -- Apply highlights
  local highlights = require("scout.highlights")
  highlights.setup(colors)
end

-- Auto-load when required
M.load()

return M
