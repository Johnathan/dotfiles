" Pathogen Stuff
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype on
filetype plugin on

let mapleader = ','

" File Search Stuff
noremap <leader>p <Esc>:CommandT<CR>

colorscheme Tomorrow-Night
set t_Co=256
hi Search ctermfg=Green ctermbg=NONE cterm=bold,underline
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
set showcmd

" GUI Stuff
if has( "gui_running" )
    set guioptions=egmrt
	set transparency=5
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

" NERDTree
nmap ntt :NERDTreeToggle<cr>
nmap nhl :nohlsearch<cr>

" Ctrl + [hjkl] to switch between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch Buffer
:nnoremap <leader>; :buffers<CR>:buffer<Space>

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
