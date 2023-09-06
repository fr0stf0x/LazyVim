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
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "folke/edgy.nvim",
    keys = {
      {
        "<leader>uE",
        false,
      },
      {
        "<leader>ue",
        false,
      },
      {
        "<C-n>",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      { "<leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "Branches" },
      { "<leader>gt", "<Cmd>Telescope git_status<CR>", desc = "Status" },
      { "<leader>f<CR>", "<Cmd>Telescope resume<CR>", desc = "Resume" },
      { "<leader>fw", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fs", "<Cmd>Telescope grep_string<CR>", desc = "Find current word" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<a-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { no_ignore = true, default_text = line })()
            end,
            ["<a-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { hidden = true, default_text = line })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-d>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-u>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-d>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-u>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
        },
      },
    },
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
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings = {
        ["l"] = "open",
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
    "lewis6991/gitsigns.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
      },
    },
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
    "Wansmer/treesj",
    keys = {
      { "<leader>ts", "<Cmd>TSJSplit<CR>", desc = "TreeSJ Split" },
      { "<leader>tj", "<Cmd>TSJJoin<CR>", desc = "TreeSJ Join" },
      { "<leader>m", "<Cmd>TSJToggle<CR>", desc = "TreeSJ Toggle" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({--[[ your config ]]
        use_default_keymaps = false,
      })
    end,
  },
}
