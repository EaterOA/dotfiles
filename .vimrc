" line numbers
set nu

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
command W w

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
