local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

local telescope = require('telescope')
local actions = require('telescope.actions')


telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- layout_strategy = 'vertical',
    -- layout_config = { height = 0.95 },
    mappings = { 
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
	      ["<C-c>"] = actions.close,
      }
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

telescope.load_extension('fzf')

