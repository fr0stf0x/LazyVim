local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>/", false },
    { "<leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "Branches" },
    { "<leader>gt", "<Cmd>Telescope git_status<CR>", desc = "Status" },
    { "<leader>f<CR>", "<Cmd>Telescope resume<CR>", desc = "Resume" },
    { "<leader>fw", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fs", "<Cmd>Telescope grep_string<CR>", desc = "Find current word" },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current buffer" },
  },
  opts = function(_, opts)
    local function flash(prompt_bufnr)
      if not LazyVim.has("flash.nvim") then
        return
      end

      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end

    local open_with_trouble = require("trouble.sources.telescope").open

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<c-t>"] = open_with_trouble,
          ["<a-t>"] = open_with_trouble,
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
          ["<C-A-J>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-A-K>"] = function(...)
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
          ["<c-s>"] = flash,
        },
        n = {
          ["s"] = flash,
          ["<c-t>"] = open_with_trouble,
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
    })
  end,
}
