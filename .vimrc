" relative line numbers
set relativenumber
" but absolute on selected line
set number

" indenting based on language
set autoindent
filetype plugin indent on

" 4 space indentation
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" syntax highlighting
syntax on

" changes syntax highlighting colors
set background=dark

" prevent smartindent from unindenting comments
au! FileType python inoremap # X#

" map :W to :w
cabbrev W w

" map :X to :x
cabbrev X x

" disable man page search
" useless to me, and annoying as hell when visual lining
map <S-k> <Nop>

" change tab-complete behavior
""" first tap: complete to longest possible match
""" second+ tap: list autocomplete options
set wildmode=longest,list

" incremental search while entering search terms
set incsearch

" highlight search matches
set hlsearch

" highlight matching parentheses/braces/etc
set showmatch

" no need for Ex mode
map q: <Nop>
nnoremap Q <nop>

" ignore case when searching
set ignorecase
" unless you have capitalized letters
set smartcase

" absolute line number in insert mode
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" map ctrl-c to escape in insert mode
imap <C-c> <Esc>
