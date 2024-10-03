return {
  {
    "aserowy/tmux.nvim",
    event = "BufWinEnter",
    keys = {
      { "<C-A-h>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "Resize Left" },
      { "<C-A-j>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "Resize bottom" },
      { "<C-A-k>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "Resize top" },
      { "<C-A-l>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "Resize right" },
    },
    opts = {
      resize = {
        enable_default_keybindings = false,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    },
  },
}
