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

vim.cmd([[
  nnoremap <Leader>L "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>

  xnoremap <Leader>L "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>
]])

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
map("i", "<C-j>", "<Down>", { remap = true })
map("i", "<C-k>", "<Up>", { remap = true })

map("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { desc = "Jump to context" })

map("n", "<leader>bc", ":%bd|e#<CR>", { desc = "Close other buffers" })

map("n", "<A-O>", function()
  local ts = require("typescript").actions
  ts.addMissingImports({ sync = true })
  ts.organizeImports()
  ts.removeUnused()
end, { desc = "TypeScript organize imports" })

-- Move Lines
map("n", "<A-S-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-S-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("i", "<A-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("v", "<A-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
