require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
--  open_on_setup       = false,
--  ignore_ft_on_setup  = {},
--  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
--  update_to_buf_dir   = {
--    enable = true,
--    auto_open = true,
--  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 40,
    -- height = 40,
    hide_root_folder = true,
    side = 'left',
    -- auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 40,
        height = 40,
        row = 5,
        col = 10,
      },
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
