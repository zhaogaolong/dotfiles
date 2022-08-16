-- cmd = vim.cmd
-- g = vim.g
-- opt = vim.opt
-- map = vim.api.nvim_set_keymap
-- default_opts = { noremap = true, silent = true }
-- fn = vim.fn


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
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
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


require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Go plugin
  use 'fatih/gomodifytags'
  use{
    'fatih/vim-go',
    ft = {'go'},
  } 
  
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    -- config = function() require'nvim-tree'.setup {} end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
      opt = true,
    } 
  }

  use 'simrat39/symbols-outline.nvim'
  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'folke/trouble.nvim',
      "ray-x/lsp_signature.nvim",
    },
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

  -- git
  use  'tpope/vim-fugitive' -- git command
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release' -- To use the latest release
  }

  -- theme
  use 'phanviet/vim-monokai-pro'
  use 'joshdick/onedark.vim'
  use 'liuerfire/vim-code-dark'
  
  -- color 
  use 'norcalli/nvim-colorizer.lua'
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- utils 
  use 'ctrlpvim/ctrlp.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  }

end)

-- plugin config
require("config-lualine")
require("config-nvim-tree")
require("config-indent-blackline")
require("config-gitsigns")
require("config-telescope")
require("config-lsp")
-- require'navigator'.setup()
-- require("config-treesister")

require("keymaps")
require("settings")

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}


