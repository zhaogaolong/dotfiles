-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }

  -- https://github.com/wbthomason/packer.nvim/issues/750
  table.insert(vim.opt.runtimepath, 1, vim.fn.stdpath('data') .. '/site/pack/*/start/*')

end


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

vim.cmd 'packadd packer.nvim'

vim.g.symbols_outline = {...}

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Go plugin
  use 'fatih/gomodifytags'
  use{
    'fatih/vim-go',
    ft = {'go'},
  } 
  
  -- down status
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require("plugin.nvim-tree") end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
      opt = true,
    },
    config = function() require("plugin.lualine") end,
  }

  -- 竖线
  use {
    'lukas-reineke/virt-column.nvim',
    config = function() require("virt-column").setup() end,
  }

  -- top table
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
          separator_style = 'slant', -- slant, padded_slant, thick
          numbers = 'ordinal',

        }
      }
    end,
  }

  -- tag bar
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup{
        auto_close = true,
        show_numbers = true,
        position = 'left',
        lsp_blacklist = {
          'Variable',
        },
        symbol_blacklist = {
          'Variable',
        },
      }
    end,
  }
  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'folke/trouble.nvim',
      "ray-x/lsp_signature.nvim",
    },
    config = function() require("plugin.lsp") end,
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
    },
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = function() require "lsp_signature".setup({}) end,
  }

  -- git
  use  'tpope/vim-fugitive' -- git command
  use  'tpope/vim-surround' -- work change
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release', -- To use the latest release
    config = function() require("plugin.gitsigns") end,
  }

  -- theme
  use 'phanviet/vim-monokai-pro'
  use 'joshdick/onedark.vim'
  use 'tomasiser/vim-code-dark'
  use 'Mofiqul/dracula.nvim'
  
  -- color 
  use {
    'norcalli/nvim-colorizer.lua',
    ft = {'css', 'html'},
    config = function() require('plugin.colorizer') end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- utils 
  use 'ctrlpvim/ctrlp.vim'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require("plugin.indent-blackline") end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()  require("plugin.telescope") end,
  }

  -- toys
  use {
    'eandrju/cellular-automaton.nvim',
    config = function()  require("plugin.cellular-automaton") end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require('packer').sync()
  end
end)

require("keymaps")
require("settings")

