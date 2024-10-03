require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Old files" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Close all buffers" })

map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("i", "<C-a>", "<Home>", { desc = "edit: Home" })
map("i", "<C-e>", "<End>", { desc = "edit: End" })
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

if not vim.g.vscode then
  map("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
  map("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
  map("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
  map("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })

  map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: Open" })
  map("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Diffview: Close" })
end

map("n", "[g", function()
  require("treesitter-context").go_to_context()
end, { desc = "Jump to context" })

map("n", "<leader>bc", ":%bd|e#<CR>", { desc = "Close other buffers" })

-- yank and paste to system clipboard
map("x", "p", "P")
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_X')

-- multi modes
map("i", "<C-k>", "<Up>", { desc = "Move up" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Disable mappings
nomap("n", "<leader>b")
nomap("n", "<tab>")
nomap("n", "<S-tab>")

-- Custom cmd
vim.cmd [[
  nnoremap <Leader>L "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>

  xnoremap <Leader>L "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>
]]
