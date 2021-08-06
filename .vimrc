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


"Status line Config
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

" Plugins installed with plug *************************
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
Plug 'roxma/vim-paste-easy'
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
call plug#end()
" Plugins installed with plug *************************

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

function YTC()
	execute ':normal! gv"yy'
	call system('xclip -selection clipboard', @y)
endfunction

" To use autoformater for neovim in python
let g:python3_host_prog="/usr/bin/python3.6"
"let g:python_host_prog="/usr/bin/python2.7"
noremap <F3> :Autoformat<CR>
au BufWrite *.py,*.c,*.js :Autoformat
let g:formatterpath = ['/home/sebastian/.local/bin/autopep8']
"let g:formatdef_semistandard_js = '"semistandard --fix --stdin"'
"let g:formatters_javascript = ['semistandard_js']

" Emmet shortcuts
let g:user_emmet_mode='n'
let g:user_emmet_leader_key='<space>'

"coc always using node v14.17.4
let g:coc_node_path='/home/sebastian/.nvm/versions/node/v14.17.4/bin/node'

"Ale configuration
let g:ale_javascript_standard_executable = '/usr/bin/semistandard'
let g:ale_javascript_standard_use_global = 1
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_fix_on_save = 1

function FilesJS()
	set tabstop=2
	set shiftwidth=2
	set expandtab
endfunction

if has('autocmd')
	augroup jsfiles
		" autocmd FileReadPost *.js echo 'expand("%:p:h")'
		" autocmd BufRead *.js echo 'expand("%:p:h")'
		autocmd!
		au BufRead *.js call FilesJS()
	augroup END
endif


