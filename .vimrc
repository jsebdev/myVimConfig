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
	au FileType c :inoreabbrev <buffer> ret return() <left>
	au FileType c setlocal foldmethod=syntax
augroup END

augroup pythonFiles
	autocmd!
	au FileType python setlocal foldmethod=indent
augroup END

augroup jsFiles
	autocmd!
	au BufRead *.js call FilesJS()
augroup END

augroup htmlFiles
	autocmd!
	au BufNewFile,BufRead *.html setlocal nowrap
	au FileType html nnoremap <buffer> <localleader>f Vatzf
	au FileType html nnoremap <buffer> 
augroup END

augroup vimFiles
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup allFiles
	autocmd!
	"au FileType * :normal! zR
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
"au BufWrite *.py,*.c,*.js,*html :Autoformat
let g:formatterpath = ['/home/sebastian/.local/bin/autopep8']
"let g:formatdef_semistandard_js = '"semistandard --fix --stdin"'
"let g:formatters_javascript = ['semistandard_js']

" Emmet shortcuts
let g:user_emmet_mode='n'
let g:user_emmet_leader_key='<space>'

"coc always using node v14.17.4
let g:coc_node_path='/home/sebastian/.nvm/versions/node/v14.17.4/bin/node'
"}}}
