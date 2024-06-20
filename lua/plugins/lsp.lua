return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "proto", "svelte" })
      end
      -- opts.matchup = {
      --   enable = true,
      --   disable = { "typescript" },
      -- }

      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      opts.servers.bufls = {
        root_dir = lspconfig.util.root_pattern("buf.work.yaml", "go.mod"),
      }

      opts.servers.svelte = {}
      opts.servers.unocss = {
        -- handlers = {
        --   ["textDocument/documentHighlight"] = function() end,
        -- },
      }

      return opts
    end,
  },
  {
    "vuki656/package-info.nvim",
    opts = {},
    event = "BufRead package.json",
  },
}
