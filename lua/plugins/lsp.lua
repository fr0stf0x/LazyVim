return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    opts.servers.bufls = {
      root_dir = lspconfig.util.root_pattern("buf.work.yaml", "go.mod"),
    }

    return opts
  end,
}
