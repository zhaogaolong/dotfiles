call plug#begin()
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Go plugin
Plug 'fatih/vim-go', { 'for': ['go'] }

" Go struct tag
Plug 'fatih/gomodifytags'
Plug 'ctrlpvim/ctrlp.vim'

" file manager
"" Plug 'preservim/nerdtree'
"" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" file icons
Plug 'ryanoasis/vim-devicons'
Plug 'adelarsq/vim-devicons-emoji'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 语法高亮
" Plug 'sheerun/vim-polyglot'
" Plug 'nvim-treesitter/nvim-treesitter'

" themes 
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'

" git
Plug 'tpope/vim-fugitive' " airline status bar require
Plug 'airblade/vim-gitgutter'

" 注释插件
Plug 'preservim/nerdcommenter'

"" icon
Plug 'ryanoasis/vim-devicons'

"" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" like tagbar
Plug 'liuchengxu/vista.vim'
" Plug 'preservim/tagbar'


" formater
Plug 'prettier/vim-prettier', {'do': 'yarn install', 'branch': 'release/0.x', 'for': ['markdown', 'yaml', 'json'] }

"" spell check
"" Plug 'reedes/vim-lexical, {'on': }'

"" rust
Plug 'rust-lang/rust.vim', {'for': ['rust',]}


" " assuming you're using vim-plug: https://github.com/junegunn/vim-plug
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" 
" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
" 
" " IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect
" 
" " NOTE: you need to install completion sources to get completions. Check
" " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
call plug#end()

let g:node_client_debug = 1


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('v0.5.0-nightly') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>




"" " TextEdit might fail if hidden is not set.
"" set hidden
"" 
"" " Give more space for displaying messages.
"" set cmdheight=2
"" 
"" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" " delays and poor user experience.
"" set updatetime=300
"" 
"" " Don't pass messages to |ins-completion-menu|.
"" set shortmess+=c
"" 
"" " Always show the signcolumn, otherwise it would shift the text each time
"" 
"" """ nerdtree plugin config
"" let g:NERDTreeDirArrowExpandable = ''
"" let g:NERDTreeDirArrowCollapsible = ''" diagnostics appear/become resolved.
"" if has("patch-8.1.1564")
""   " Recently vim can merge signcolumn and number column into one
""   set signcolumn=number
"" else
""   set signcolumn=yes
"" endif
"" 
"" " Use tab for trigger completion with characters ahead and navigate.
"" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" " other plugin before putting this into your config.
"" inoremap <silent><expr> <TAB>
""       \ pumvisible() ? "\<C-n>" :
""       \ <SID>check_back_space() ? "\<TAB>" :
""       \ coc#refresh()
"" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"" 
"" function! s:check_back_space() abort
""   let col = col('.') - 1
""   return !col || getline('.')[col - 1]  =~# '\s'
"" endfunction
"" 
"" " Use <c-space> to trigger completion.
"" inoremap <silent><expr> <c-space> coc#refresh()
"" 
"" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" " position. Coc only does snippet and additional edit on confirm.
"" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
"" if exists('*complete_info')
""   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"" else
""   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" endif
"" 
"" " Use `[g` and `]g` to navigate diagnostics
"" nmap <silent> [g <Plug>(coc-diagnostic-prev)
"" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"" 
"" " GoTo code navigation.
"" nmap <silent> gd <Plug>(coc-definition)
"" nmap <silent> gy <Plug>(coc-type-definition)
"" nmap <silent> gi <Plug>(coc-implementation)
"" nmap <silent> gr <Plug>(coc-references)
"" 
"" " Use K to show documentation in preview window.
"" nnoremap <silent> K :call <SID>show_documentation()<CR>
"" 
"" function! s:show_documentation()
""   if (index(['vim','help'], &filetype) >= 0)
""     execute 'h '.expand('<cword>')
""   else
""     call CocAction('doHover')
""   endif
"" endfunction
"" 
"" " Highlight the symbol and its references when holding the cursor.
"" autocmd CursorHold * silent call CocActionAsync('highlight')
"" 
"" " Symbol renaming.
"" nmap <leader>rn <Plug>(coc-rename)
"" 
"" " Formatting selected code.
"" xmap <leader>f  <Plug>(coc-format-selected)
"" nmap <leader>f  <Plug>(coc-format-selected)
"" 
"" augroup mygroup
""   autocmd!
""   " Setup formatexpr specified filetype(s).
""   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
""   " Update signature help on jump placeholder.
""   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"" augroup end
"" 
"" " Applying codeAction to the selected region.
"" " Example: `<leader>aap` for current paragraph
"" xmap <leader>a  <Plug>(coc-codeaction-selected)
"" nmap <leader>a  <Plug>(coc-codeaction-selected)
"" 
"" " Remap keys for applying codeAction to the current buffer.
"" nmap <leader>ac  <Plug>(coc-codeaction)
"" " Apply AutoFix to problem on the current line.
"" nmap <leader>qf  <Plug>(coc-fix-current)
"" 
"" " Map function and class text objects
"" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"" xmap if <Plug>(coc-funcobj-i)
"" omap if <Plug>(coc-funcobj-i)
"" xmap af <Plug>(coc-funcobj-a)
"" omap af <Plug>(coc-funcobj-a)
"" xmap ic <Plug>(coc-classobj-i)
"" omap ic <Plug>(coc-classobj-i)
"" xmap ac <Plug>(coc-classobj-a)
"" omap ac <Plug>(coc-classobj-a)
"" 
"" " Use CTRL-S for selections ranges.
"" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"" nmap <silent> <C-s> <Plug>(coc-range-select)
"" xmap <silent> <C-s> <Plug>(coc-range-select)
"" 
"" " Add `:Format` command to format current buffer.
"" command! -nargs=0 Format :call CocAction('format')
"" 
"" " Add `:Fold` command to fold current buffer.
"" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"" 
"" " Add `:OR` command for organize imports of the current buffer.
"" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"" 
"" " Add (Neo)Vim's native statusline support.
"" " NOTE: Please see `:h coc-status` for integrations with external plugins that
"" " provide custom statusline: lightline.vim, vim-airline.
"" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"" 
"" " Mappings using CoCList:
"" " Show all diagnostics.
"" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" " Manage extensions.
"" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" " Show commands.
"" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" " Find symbol of current document.
"" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" " Search workspace symbols.
"" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" " Do default action for next item.
"" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" " Do default action for previous item.
"" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" " Resume latest coc list.
"" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"" 

""" zhaogaolong nvim config 
syntax on
filetype plugin indent on
set nocompatible

set encoding=UTF-8
set noswapfile
set noundofile
set number
" set relativenumber

" 光标十字架
" set cursorline cursorcolumn
" hi CursorLine term=bold cterm=bold guibg=Grey40



" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" set color
"" colorscheme onedark
" colorscheme sonokai
colorscheme monokai_pro
" colorscheme sublimemonokai
set t_Co=256
" highlight CursorLineNr ctermfg=green

" view tab and space
set list
set listchars+=space:.

" vim copy to chlipborad
set clipboard=unnamedplus
" vim copy to chlipborad
" set mouse=a


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


""" nerdtree plugin config
" 自动打开和关闭快捷键
" map <C-n> :NERDTreeToggle<CR>
map <C-n> :CocCommand explorer<CR>


" 如果只剩一个窗口的话，该窗口关闭的时候自动关闭
"" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""" airline config 
" let g:airline_theme='violet'
"" let g:airline_theme='dark'
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]

let g:airline#extensions#hunks#enabled = 0

let g:airline#extensions#coc#enabled = 1

""" vim-polyglot plugin config
let g:polyglot_disabled = ['css']


""" nerdtree plugin config
" let g:NERDTreeDirArrowExpandable = ''
" let g:NERDTreeDirArrowCollapsible = ''
" let NERDTreeShowHidden = 0
" au VimEnter *  NERDTree
" NERDTress File highlighting
" 
""" vim-nerdtree-syntax-highlight plugin config
" let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
" let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
" 
" let g:NERDTreeDisableFileExtensionHighlight = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
" let g:NERDTreeDisablePatternMatchHighlight = 1
" 
" let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

""" git plugin config 
let g:gitgutter_terminal_reports_focus=0

"" preservim/nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

""" vim-go plugin config 
let g:go_fmt_command = "goimports"
let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1

let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

let g:go_addtags_transform = 'camelcase'

""" coc explorer config

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets

""" vim-devicons plugin config
let g:webdevicons_enable = 1
let g:WebDevIconsOS = 'Darwin'
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
"

""" fzf
""  set rtp+=/usr/local/opt/fzf
let g:fzf_preview_window = ''
let g:fzf_preview_window = 'right:60%'

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "all",     -- one of "all", "language", or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"   },
"   custom_captures = {
"     -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
"     ["foo.bar"] = "Identifier",
"   },
" }
" EOF

""" sonokai theme config 
" let g:sonokai_style = '𝐀𝐧𝐝𝐫𝐨𝐦𝐞𝐝𝐚'
"" let g:sonokai_style = 'maia'
colorscheme onedark


"""
"""  reedes/vim-lexical plugin config
"""
" set spell
" hi clear SpellBad
" hi SpellBad cterm=underline """ 下划线
" augroup lexical
"   autocmd!""
"   autocmd FileType markdown,mkd call lexical#init()
"   autocmd FileType textile call lexical#init()
"   autocmd FileType yaml call lexical#init()
"   autocmd FileType go call lexical#init()
"   autocmd FileType text call lexical#init({ 'spell': 0 }) " disable text spell check
" augroup END
" let g:lexical#spell = 1         " 0=disabled, 1=enabled
" let g:lexical#spelllang = ['en_us',]
" let g:lexical#spell_key = '<leader>s'
" let g:lexical#thesaurus_key = '<leader>t'
" let g:lexical#dictionary_key = '<leader>k'

"""
""" tagbar plugin configs
"""
" map <C-m> :TagbarToggle<CR>
" let g:tagbar_height = 60
" let g:tagbar_left = 1

"""
""" vista.vim plugin configs
"""
nmap <C-m> :Vista!!<CR>
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
let g:vista_sidebar_position='vertical topleft'
let g:vista_sidebar_width=50

""" airblade/vim-gitgutter plugin config
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 1


""" prettier plugin config
let g:prettier#autoformat = 1


""### nvim config ########
"" search highlights
set hlsearch
hi Search ctermbg=yellow
hi Search ctermfg=black


"" ### rust config ########
let g:rustfmt_autosave = 1

let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }

let g:rust_clip_command = 'pbcopy'

" let g:iconGo = ''

