local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost init.lua source <afile> | PackerSync
--   augroup end
-- ]]


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
-- require("config-treesister")


-- nvim options config
map('', '<Space>', '<Nop>', default_opts)
g.mapleader = ' '
g.maplocalleader = ' '

map('n', '<leader>ee', ':NvimTreeToggle<CR>', default_opts)

cmd [[
  command! AF :Telescope find_files find_command=fd,--type,f,--hidden,--follow,--exclude,.git,--no-ignore, previewer=false
  command! FF :Telescope find_files find_command=fd,--type,f,--hidden,--follow,--exclude,.git, previewer=false

]]


map('n', '<leader>af', ':AF<CR>', default_opts)
map('n', '<leader>ff', ':FF<CR>', default_opts)
-- map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], default_opts)
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], default_opts)
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], default_opts)
map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], default_opts)
map('n', '<leader>rg', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], default_opts)
map('n', '<leader>gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], default_opts)
map('n', '<leader>co', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], default_opts)
map('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], default_opts)



--options config 
opt.swapfile = false
opt.hidden = true
opt.cmdheight = 1
opt.updatetime = 300
opt.encoding = 'UTF-8'
-- opt.relativenumber = true
opt.number = true
opt.showmatch = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

opt.mouse = 'a'
opt.termguicolors = true
opt.listchars='tab:⇢ ,eol:¬,trail:·,extends:↷,precedes:↶'
opt.showbreak='↪'

-- vim 选择数据块复制到粘贴板
opt.clipboard = 'unnamedplus'

g.syntax = true
g.ignorecase = true
g.list = true

-- cmd('colorscheme monokai_pro')
cmd('colorscheme codedark')

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

cmd('hi DiffAdd guibg=#2D2D2D guifg=#57FF00 ctermbg=none')
cmd('hi DiffChange guibg=#2D2D2D guifg=#FFEF02 ctermbg=none')
cmd('hi DiffDelete guibg=#2D2D2D guifg=Red ctermbg=none')


-- autocommand
cmd [[
  autocmd BufWritePre *.go,*.rs,*.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd FileType go,make setlocal shiftwidth=4 tabstop=4 noexpandtab
]]



-- let g:nvim_tree_icons = {
--     \ 'default': '',
--     \ 'symlink': '',
--     \ 'git': {
--     \   'unstaged': "✗",
--     \   'staged': "✓",
--     \   'unmerged': "",
--     \   'renamed': "➜",
--     \   'untracked': "★",
--     \   'deleted': "",
--     \   'ignored': "◌"
--     \   },
--     \ 'folder': {
--     \   'arrow_open': "",
--     \   'arrow_closed': "",
--     \   'default': "",
--     \   'open': "",
--     \   'empty': "",
--     \   'empty_open': "",
--     \   'symlink': "",
--     \   'symlink_open': "",
--     \   }
--     \ }


