require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    --- theme = 'evil_lualine',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
      }
    },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
      'filename',
        file_status = true,   -- displays file status (readonly status, modified status)
        path = 1,             -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40, -- Shortens path to leave 40 space in the window
                              -- for other components. Terrible name any suggestions?
        symbols = {
          modified = '[+]',      -- when the file was modified
          readonly = '[-]',      -- if the file is not modifiable or readonly
          unnamed = '[No Name]', -- default display name for unnamed buffers
        }
      },
      'lsp_progress',
    },
    lualine_x = {
      {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = '  LSP:',
        color = { fg = '#fffffff', gui = 'bold' },
      },
      'encoding',
      {
        'fileformat',
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        }
      },
      {
        'filetype',
         colored = true,
         icon_only = false, -- filetype name and icon
      }
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
}

-- require("toggleterm").setup{
--   persist_size = true,
--   close_on_exit = true,
--   direction = 'float',
--   float_opts = {
--     border = 'single'
--   }
-- }
