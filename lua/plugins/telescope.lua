return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      local telescope = require "telescope.actions"
      local open_with_trouble = require("trouble.sources.telescope").open

      local function flash(prompt_bufnr)
        require("flash").jump {
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
        }
      end

      conf.defaults.mappings = {
        i = {
          ["<c-t>"] = open_with_trouble,
          ["<a-t>"] = open_with_trouble,
          ["<a-i>"] = function()
            local action_state = require "telescope.actions.state"
            local line = action_state.get_current_line()
            telescope("find_files", { no_ignore = true, default_text = line })()
          end,
          ["<a-h>"] = function()
            local action_state = require "telescope.actions.state"
            local line = action_state.get_current_line()
            telescope("find_files", { hidden = true, default_text = line })()
          end,
          ["<C-A-J>"] = function(...)
            return telescope.cycle_history_next(...)
          end,
          ["<C-A-K>"] = function(...)
            return telescope.cycle_history_prev(...)
          end,
          ["<C-j>"] = function(...)
            return telescope.move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return telescope.move_selection_previous(...)
          end,
          ["<C-d>"] = function(...)
            return telescope.preview_scrolling_down(...)
          end,
          ["<C-u>"] = function(...)
            return telescope.preview_scrolling_up(...)
          end,
          ["<c-s>"] = flash,
        },
        n = {
          ["s"] = flash,
          -- ["<c-t>"] = open_with_trouble,
          ["q"] = function(...)
            return telescope.close(...)
          end,
          ["<C-Down>"] = function(...)
            return telescope.cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return telescope.cycle_history_prev(...)
          end,
          ["<C-j>"] = function(...)
            return telescope.move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return telescope.move_selection_previous(...)
          end,
          ["<C-d>"] = function(...)
            return telescope.preview_scrolling_down(...)
          end,
          ["<C-u>"] = function(...)
            return telescope.preview_scrolling_up(...)
          end,
        },
      }
      -- or
      -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  },
}
