return {

  {
    "nvchad/ui",
    enabled = not vim.g.vscode,
    config = function()
      require("nvchad")
    end,
  },

  {
    "nvchad/base46",
    enabled = not vim.g.vscode,
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/volt",
    enabled = not vim.g.vscode,
  },
  {

    "nvchad/menu",
    enabled = not vim.g.vscode,
  },
  {

    "nvchad/minty",
    enabled = not vim.g.vscode,
  },
}
