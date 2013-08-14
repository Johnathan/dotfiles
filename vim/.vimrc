" Pathogen Stuff
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype on
filetype plugin on

au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.coffee set filetype=coffee

let mapleader = ','

" File Search Stuff
noremap <leader>p <Esc>:CommandT<CR>

if has('gui_running')
    set background=light
else
    set background=dark
endif

colorscheme Tomorrow-Night-Eighties
set t_Co=256
hi Search ctermfg=Green ctermbg=NONE cterm=bold,underline
set number
set tabstop=4
set shiftwidth=4
"set tabstop=2
"set shiftwidth=2
set expandtab
set guifont=Source\ Code\ Pro:h14
set linespace=5
set smartindent
set autoindent
set wildmode=list:longest
set splitbelow
set foldenable
" set foldmethod=syntax
set foldcolumn=1
set hlsearch
set ruler
set timeoutlen=500
set showcmd
set mouse=a

" GUI Stuff
if has( "gui_running" )
    set guioptions=egmrt
endif

set clipboard=unnamed

nmap <space> :

" Move 5 at a time
nmap H 5h
nmap J 5j
nmap K 5k
nmap L 5l

" Tag BarToggle
nmap tt :TagbarToggle<cr>

" Numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" NERDTree
nmap ntt :NERDTreeToggle<cr>
nmap nhl :nohlsearch<cr>

" Ctrl + [hjkl] to switch between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch Buffer
noremap <leader>; <Esc>:CommandTBuffer<CR>

" Gets rid of whitespace at end of line
autocmd BufWritePre * :%s/\s\+$//e


" Comments
inoremap /*<CR>	  /*<CR>*/<Esc>O

" Shortcut for VIMRC file
nmap ev :tabedit $MYVIMRC<cr>

" Update vimrc file when saved
if has( "autocmd" )
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
