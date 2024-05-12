-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.swapfile = false

local opt = vim.opt

opt.wrap = false
opt.conceallevel = 0
opt.spell = false
opt.spelllang = ""

vim.filetype.add({
  extension = {
    mdx = "mdx",
    postcss = "postcss",
  },
})

vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("css", "postcss")

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

-- neovide
vim.o.guifont = "MonoLisaStatic Nerd Font:h15"
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0
