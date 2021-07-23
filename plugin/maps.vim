let mapleader=" "

" Tabs keys
nmap <Leader>t :tabnew
nmap <Leader>l :tabnext<CR>
nmap <Leader>h :tabprevious<CR>
"nmap <Leader>q :tabclose<CR>

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>w :w<CR>
nmap <Leader>W :wa<CR>
nmap <Leader>q :q<CR>
nmap <Leader>Q :qa<CR>
nmap <Leader>e :e
vmap <Leader>y :call YTC()<CR>

nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>gs :CocSearch

"Escape easily
imap <silent> jj <esc>
vmap <silent> qq <esc>
nmap <silent> qq <esc>


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
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i

" Edit VIMRC FROM ANYWHERE
nnoremap <leader>xe :call EditVIMRC()<CR>|          " n_<leader>xe    -> edit VIMRC
function! EditVIMRC()
	execute ':silent tabedit $MYVIMRC'
	echom ".vimrc"
endfunction
