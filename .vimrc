syntax on
filetype on
filetype plugin on

let mapleader = ','

" Editor settings
set number
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set smartcase
set ignorecase
set hlsearch
set timeoutlen=500
set showcmd
set mouse=a
set wildmode=list:longest
set splitbelow
set splitright
set foldenable
set clipboard=unnamedplus

" Space to enter command mode
nmap <space> :

" Move 5 at a time
nmap H 5h
nmap J 5j
nmap K 5k
nmap L 5l

" Ctrl + [hjkl] to switch between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Shortcut for vimrc
nmap ev :tabedit $MYVIMRC<cr>

" Reload vimrc on save
autocmd BufWritePost .vimrc source $MYVIMRC
