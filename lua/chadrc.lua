local M = {}

M.base46 = {
  theme = "onedark",
  -- transparency = true,
  hl_override = {
    DiffAdd = {
      bg = { "black2", "green", 10 },
      fg = { "green", "white", 5 },
    },
    DiffDelete = {
      bg = { "black", "red", 10 },
    },
  },
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },

  cmp = {
    -- style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    icons_left = true,
  },
}

return M
