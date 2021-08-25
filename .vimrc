" basic set {{{
set number
set mouse=a | "To us the mouse
set numberwidth=2
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode
set tabstop=4
set shiftwidth=4
set autoindent
set autochdir
set noautoindent
set foldnestmax=3
set foldlevelstart=99
"}}}

"Status line Config {{{
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
set statusline=%#PmenuSel# 
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=\ #buf=\ %n
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
"}}}

"Plugins installed with plug  {{{
call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
"Plug 'flazz/vim-colorschemes'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chiel92/vim-autoformat'
"Plug 'roxma/vim-paste-easy'
Plug 'scrooloose/nerdcommenter'
" Colavorative vim in real time (does not work because python)
"Plug 'FredKSchott/CoVim'
"
" HTML and CSS helper
Plug 'mattn/emmet-vim'
" To live changes when html, css and javascript -- Not working with css
" variables
" Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

Plug 'dense-analysis/ale'
Plug 'Athesto/betty-ale-vim'|       "Program
call plug#end()
" Plugins installed with plug *************************}}}

" functions {{{
function YTC()
	execute ':normal! gv"yy'
	call system('xclip -selection clipboard', @y)
endfunction

function FilesJS()
	set tabstop=2
	set shiftwidth=2
	set expandtab
endfunction
"}}}

" ale settings / linters {{{
let g:ale_javascript_standard_executable = '/usr/bin/semistandard'
let g:ale_javascript_standard_use_global = 1
let g:ale_fixers = {'javascript': ['standard'], 'python': ['autopep8']}
"let g:ale_fix_on_save = 1
nnoremap <f3> :ALEFix<CR>
let g:ale_linters = {'c':['bettystyle', 'bettydoc', 'gcc'], 'python':['pycodestyle']}
" }}}

"autocmds {{{
augroup cFiles
	autocmd!
	autocmd FileType c :inoreabbrev <buffer> ret return() <left>
	autocmd FileType c setlocal foldmethod=syntax
augroup END

augroup pythonFiles
	autocmd!
	autocmd FileType python setlocal foldmethod=indent
augroup END

augroup jsFiles
	autocmd!
	autocmd BufRead *.js call FilesJS()
augroup END

augroup htmlFiles
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
	autocmd FileType html nnoremap <buffer> 
augroup END

augroup vimFiles
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup allFiles
	autocmd!
	"autocmd FileType * :normal! zR
augroup END
"}}}

"maps  {{{
let mapleader=" "
let maplocalleader=","

"Movement mappings
onoremap p i(
onoremap s is
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>

"folds shortcuts
vnoremap <leader>f zf
nnoremap <leader>a zA

" Tabs keys
nnoremap <Leader>t :tabnew
nnoremap <Leader>l :tabnext<CR>
nnoremap <Leader>h :tabprevious<CR>

nnoremap <leader>s <Plug>(easymotion-s2)
nnoremap <Leader>nt :NERDTreeFind<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa<CR>
nnoremap <Leader>e :e
vmap <Leader>y :call YTC()<CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

nnoremap <leader>gs :CocSearch


"Escape easily
inoremap <silent> kj <esc>
inoremap <esc> <nop>
vnoremap <silent> qq <esc>

"convert words into upper case
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
nnoremap H _
vnoremap H _
nnoremap L $
vnoremap L $

" Edit VIMRC FROM ANYWHERE
nnoremap <leader>xv :vsplit $MYVIMRC<cr>
nnoremap <leader>xe :call EditVIMRC()<CR>|          " n_<leader>xe    -> edit VIMRC
function! EditVIMRC()
	execute ':silent tabedit $MYVIMRC'
	echom ".vimrc"
endfunction

" source vimrc
:nnoremap <leader>xs :source $MYVIMRC<cr>

"}}}

" extra plugin settings {{{
" Color scheme
"colorscheme molokai_dark
"GruvBox configuration
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_hls_cursor = 'purple'
colorscheme gruvbox

" Make NerdTree quit when a file is opened
let NERDTreeQuitOnOpen=1

" To show invisible characters
" set list listchars=tab:\→\ ,trail:·,eol:¶,extends:§,precedes:§,nbsp:§
set list listchars=tab:\→\ ,trail:·,extends:§,precedes:§,nbsp:§


" To use autoformater for neovim in python
let g:python3_host_prog="/usr/bin/python3.6"
"let g:python_host_prog="/usr/bin/python2.7"
"noremap <F3> :Autoformat<CR>
"autocmd BufWrite *.py,*.c,*.js,*html :Autoformat
let g:formatterpath = ['/home/sebastian/.local/bin/autopep8']
"let g:formatdef_semistandard_js = '"semistandard --fix --stdin"'
"let g:formatters_javascript = ['semistandard_js']

" Emmet shortcuts
let g:user_emmet_mode='n'
let g:user_emmet_leader_key='<space>'

"coc always using node v14.17.4
let g:coc_node_path='/home/sebastian/.nvm/versions/node/v14.17.4/bin/node'
"}}}

" COC settings  {{{
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
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
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

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
if has('nvim-0.4.0') || has('patch-8.2.0750')
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
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }}}
