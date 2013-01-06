syntax on
filetype on

let mapleader = ','

colorscheme Tomorrow-Night
set number
set tabstop=4
set shiftwidth=4
set guifont=monaco:h13
set linespace=5
set smartindent
set autoindent
set wildmode=list:longest
set splitbelow
set foldenable
set hlsearch
set ruler
set timeoutlen=500

"GUI Stuff
if has("gui_running")
    set guioptions=egmrt
	set transparency=5
endif

nmap <space> :
nmap ntt :NERDTreeToggle<cr>
nmap nhl :nohlsearch<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Gets rid of whitespace at end of line
autocmd BufWritePre * :%s/\s\+$//e


"Braces & Comments
inoremap {	  {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}	 {}
inoremap		(  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap /*<CR>	  /*<CR>*/<Esc>O

"Shortcut for VIMRC file
nmap ev :tabedit $MYVIMRC<cr>

"Update vimrc file when saved
if has( "autocmd" )
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
