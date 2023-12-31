local function on_file_remove(args)
  local ts_clients = vim.lsp.get_active_clients({ name = "tsserver" })
  for _, ts_client in ipairs(ts_clients) do
    ts_client.request("workspace/executeCommand", {
      command = "_typescript.applyRenameFile",
      arguments = {
        {
          sourceUri = vim.uri_from_fname(args.source),
          targetUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

return {
  {
    "aserowy/tmux.nvim",
    event = "BufWinEnter",
    config = function()
      return require("tmux").setup()
    end,
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
    dependencies = {
      {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
    },
    opts = function(_, opts)
      opts.window.mappings = {
        ["l"] = "open",
        ["S"] = "open_vsplit",
        ["s"] = false,
      }

      local events = require("neo-tree.events")
      opts.event_handlers = {
        {
          event = events.FILE_MOVED,
          handler = on_file_remove,
        },
        {
          event = events.FILE_RENAMED,
          handler = on_file_remove,
        },
      }
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    event = "LspAttach",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
          ---Line-comment toggle keymap
          line = "<leader>/",
          ---Block-comment toggle keymap
          block = "<C-\\>",
        },
        opleader = {
          ---Line-comment keymap
          line = "<leader>/",
          ---Block-comment keymap
          block = "<C-\\>",
        },
      })
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
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

  -- {
  --   "simeji/winresizer",
  --   cmd = "WinResizerStartResize",
  --   keys = { "<C-e>" },
  --   config = function(_, _)
  --     vim.g.winresizer_finish_with_escape = 1
  --   end,
  -- },
}
