let mapleader=" "

" Tabs keys
nnoremap <Leader>t :tabnew
nnoremap <Leader>l :tabnext<CR>
nnoremap <Leader>h :tabprevious<CR>

nnoremap <Leader>s <Plug>(easymotion-s2)
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
vnoremap <silent> qq <esc>

"convert words into upper case
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

"Function to remap { and let make a new line on not html files
"function OpenCurlyBraces()
"if &filetype == 'html'
"execute "normal! a{}\<esc>ir"
"else
"execute "normal! a{}\<esc>i\<CR>\<esc>==O\<esc>ccr"
"endif
"endfunction
"inoremap { <Esc>:call OpenCurlyBraces()<CR>i<del>
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<esc>i
inoremap ` ``<Esc>i

" Edit VIMRC FROM ANYWHERE
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>xe :call EditVIMRC()<CR>|          " n_<leader>xe    -> edit VIMRC
function! EditVIMRC()
	execute ':silent tabedit $MYVIMRC'
	echom ".vimrc"
endfunction

" source vimrc
:nnoremap <leader>sv :source $MYVIMRC<cr>
