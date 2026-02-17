" Basic settings
set nocompatible                " Use Vim defaults (not vi)
" syntax on                       " Enable syntax highlighting
filetype plugin indent on       " Enable filetype detection

" Visual
set number                      " Show line numbers
" set relativenumber              " Show relative line numbers
set showmatch                   " Highlight matching brackets
set cursorline                  " Highlight current line
set ruler                       " Show cursor position

" Search
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uppercase present
set incsearch                   " Search as you type
set hlsearch                    " Highlight search results

" Indentation
set autoindent                  " Copy indent from current line
set smartindent                 " Smart auto-indenting
set expandtab                   " Use spaces instead of tabs
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
" set softtabstop=4               " Backspace removes 4 spaces

" Persistent undo
set undofile                    " Enable persistent undo
set undodir=~/.vim/undo-history " Undo file location
set undolevels=1000             " Number of undos to save
set undoreload=10000            " Lines to save for undo on buffer reload

" Backups and swap
set nobackup                    " Don't create backup files
set nowritebackup               " Don't create backup before overwriting
set noswapfile                  " Don't create swap files

" Performance
set lazyredraw                  " Don't redraw during macros
set ttyfast                     " Faster terminal connection

" Usability
set backspace=indent,eol,start  " Backspace works on everything
set clipboard=unnamed           " Use system clipboard
set mouse=a                     " Enable mouse support
" set wildmenu                    " Visual autocomplete for command menu
" set wildmode=longest:full,full  " Command line completion mode
