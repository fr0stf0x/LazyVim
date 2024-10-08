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
  {
    "folke/todo-comments.nvim",
    event = "LspAttach",
    keys = {
      { "<leader>xt", false },
      { "<leader>xT", false },
    },
  },
  {
    "echasnovski/mini.files",
    opts = { windows = { preview = false } },
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>js", "<Cmd>TSJSplit<CR>", desc = "TreeSJ Split" },
      { "<leader>jj", "<Cmd>TSJJoin<CR>", desc = "TreeSJ Join" },
      { "<leader>jm", "<Cmd>TSJToggle<CR>", desc = "TreeSJ Toggle" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({--[[ your config ]]
        use_default_keymaps = false,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufWinEnter",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
    },
    opts = function(_, opts)
      opts.window.mappings.S = "open_vsplit"
      opts.window.mappings.s = false

      -- opts.window.mappings = {
      --   ["l"] = "open",
      --   ["S"] = "open_vsplit",
      --   ["s"] = false,
      -- }

      return opts
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    enabled = false,
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "echasnovski/mini.comment",
    opts = {
      mappings = {
        comment = "<C-\\>",
        comment_line = "<leader>/",
        comment_visual = "<leader>/",
        textobject = "<leader>/",
      },
    },
  },

  -- {
  --   "numToStr/Comment.nvim",
  --   event = "LspAttach",
  --   dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  --   config = function()
  --     require("Comment").setup({
  --       pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  --       toggler = {
  --         ---Line-comment toggle keymap
  --         line = "<leader>/",
  --         ---Block-comment toggle keymap
  --         block = "<C-\\>",
  --       },
  --       opleader = {
  --         ---Line-comment keymap
  --         line = "<leader>/",
  --         ---Block-comment keymap
  --         block = "<C-\\>",
  --       },
  --     })
  --   end,
  -- },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    enabled = false,
    opts = { marks = { GitChange = { text = "│" } } },
    config = function(_, otps)
      require("scrollbar").setup(otps)
    end,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        false,
      },
      {
        "<leader>bD",
        false,
      },
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>X",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-S-h>",
        right = "<M-S-l>",
        down = "<M-S-j>",
        up = "<M-S-k>",

        -- Move current line in Normal mode
        line_left = "<M-S-h>",
        line_right = "<M-S-l>",
        line_down = "<M-S-j>",
        line_up = "<M-S-k>",
      },
    },
  },
  {
    "Equilibris/nx.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts = {
      -- See below for config options
      nx_cmd_root = "nx",
    },

    -- Plugin will load when you use these keys
    keys = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
    },
  },
  {
    "iamyoki/buffer-reopen.nvim",
    opts = {},
  },
  -- {
  --   "chrisgrieser/nvim-lsp-endhints",
  --   event = "LspAttach",
  --   opts = {}, -- required, even if empty
  -- },
  -- {
  --   "chrisgrieser/nvim-rip-substitute",
  --   cmd = "RipSubstitute",
  --   keys = {
  --     {
  --       "<leader>sR",
  --       function()
  --         require("rip-substitute").sub()
  --       end,
  --       mode = { "n", "x" },
  --       desc = " rip substitute",
  --     },
  --   },
  -- },

  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = function(_, opts)
  --     opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
  --     return opts
  --   end,
  -- },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     local kanagawa_paper = require("lualine.themes.kanagawa-paper")
  --     opts.options.theme = kanagawa_paper
  --
  --     return opts
  --   end,
  -- },

  -- {
  --   "simeji/winresizer",
  --   cmd = "WinResizerStartResize",
  --   keys = { "<C-e>" },
  --   config = function(_, _)
  --     vim.g.winresizer_finish_with_escape = 1
  --   end,
  -- },
}
