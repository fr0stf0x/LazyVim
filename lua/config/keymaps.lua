-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

vim.api.nvim_del_keymap("n", "<A-j>")
vim.api.nvim_del_keymap("n", "<A-k>")
vim.api.nvim_del_keymap("i", "<A-j>")
vim.api.nvim_del_keymap("i", "<A-k>")
vim.api.nvim_del_keymap("v", "<A-j>")
vim.api.nvim_del_keymap("v", "<A-k>")
vim.api.nvim_del_keymap("n", "<leader>xl")
vim.api.nvim_del_keymap("n", "<leader>xq")
vim.api.nvim_del_keymap("n", "<leader>bb")

vim.cmd([[
  nnoremap <Leader>L "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>

  xnoremap <Leader>L "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>
]])

if not vim.g.vscode then
  map("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
  map("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
  map("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
  map("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })
end

map("x", "p", "P")
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_X')

map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: Open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Diffview: Close" })

map("i", "<C-a>", "<Home>", { desc = "edit: Home" })
map("i", "<C-e>", "<End>", { desc = "edit: End" })
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

map("n", "[g", function()
  require("treesitter-context").go_to_context()
end, { desc = "Jump to context" })

map("n", "<leader>bc", ":%bd|e#<CR>", { desc = "Close other buffers" })

map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
