-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.wrap = false
opt.conceallevel = 0
vim.g.swapfile = false

vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

vim.treesitter.language.register("markdown", "mdx")

vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "tsx=typescriptreact",
  "javascript",
  "typescript",
  "typescriptreact",
  "bash",
  "lua",
  "go",
  "rust",
}
