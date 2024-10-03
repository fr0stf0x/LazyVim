if not vim.g.vscode then
  vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if not vim.g.vscode then
  -- To load all base46 integrations at once
  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
  end
end
