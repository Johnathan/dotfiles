syntax on
filetype on
filetype plugin on

let mapleader = ','

if has('gui_running')
    set background=light
else
    set background=dark
endif

set t_Co=256
hi Search ctermfg=Green ctermbg=NONE cterm=bold,underline
set number
set tabstop=4
set shiftwidth=4
set smartcase
set tabstop=2
set shiftwidth=2
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

" Numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

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

function! s:expand_commit_template() abort
  let context = {
    \ 'MY_BRANCH': matchstr(system("git rev-parse --abbrev-ref HEAD | sed 's:.*/::'"), '\p\+')
  \ }

  let lnum = nextnonblank(1)
  while lnum && lnum < line('$')
    call setline(lnum, substitute(getline(lnum), '\${\(\w\+\)}',
    \ '\=get(context, submatch(1), submatch(0))', 'g'))
    let lnum = nextnonblank(lnum + 1)
  endwhile
endfunction

autocmd BufRead */.git/COMMIT_EDITMSG call s:expand_commit_template()
