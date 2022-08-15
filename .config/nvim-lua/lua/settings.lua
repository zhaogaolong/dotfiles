vim.g.syntax = true
vim.g.ignorecase = true
vim.g.list = true

--options config 
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.encoding = 'UTF-8'

-- opt.relativenumber = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.listchars='tab:⇢ ,eol:¬,trail:·,extends:↷,precedes:↶'
vim.opt.showbreak='↪'

-- vim 选择数据块复制到粘贴板
vim.opt.clipboard = 'unnamedplus'

vim.cmd('colorscheme codedark')

vim.cmd('hi DiffAdd guibg=#2D2D2D guifg=#57FF00 ctermbg=none')
vim.cmd('hi DiffChange guibg=#2D2D2D guifg=#FFEF02 ctermbg=none')
vim.cmd('hi DiffDelete guibg=#2D2D2D guifg=Red ctermbg=none')

vim.wo.foldlevel = 99
vim.wo.foldenable = true


-- autocommand
--- cmd [[
---   autocmd BufWritePre *.go,*.rs,*.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
---   autocmd FileType go,make setlocal shiftwidth=4 tabstop=4 noexpandtab
---   autocmd FileType python setlocal colorcolumn=79
--- ]]
-- cmd [[
--   autocmd BufWritePre *.go,*.rs,*.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
-- ]]

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go,*.rs,*.vue',
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 1000)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.colorcolumn = 79
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    -- vim.opt_local.noexpandtab = true
  end,
})


vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go,make',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    -- vim.opt_local.noexpandtab = false
  end,
})
