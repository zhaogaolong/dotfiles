vim.keymap.set('', '<Space>', '<nop>')
vim.g.mapleader = ' '

-- map('', '<Space>', '<Nop>', default_opts)
-- g.mapleader = ' '
-- g.maplocalleader = ' '

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tt', ':SymbolsOutline<CR>')
vim.keymap.set('n', '<leader>,', ':tabnext<CR>')
vim.keymap.set('n', '<leader>.', ':tabprevious<CR>')

vim.cmd [[
  command! AF :Telescope find_files find_command=fd,--type,f,--hidden,--follow,--exclude,.git,--no-ignore, previewer=false
  command! FF :Telescope find_files find_command=fd,--type,f,--hidden,--follow,--exclude,.git, previewer=false
]]

vim.cmd('colorscheme codedark')


vim.keymap.set('n', '<leader>af', ':AF<CR>')
vim.keymap.set('n', '<leader>ff', ':FF<CR>')

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>rg', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references)
vim.keymap.set('n', '<leader>co', require('telescope.builtin').lsp_document_symbols)
vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
-- .setlsp restart
vim.keymap.set('n', '<leader>lr', ':LspRestart<cr>')
