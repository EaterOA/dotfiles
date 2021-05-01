"---------------------------------------------------------------
" numbering stuff
"
" I use a numbering scheme adapted from:
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
"
" As a proxy for determining whether our scheme should be on or not, we use
" our own "relnum" and "nonum" variables
let s:relnum=1
let s:nonum=0

function EvaluateNumbering()
    if s:nonum
        set norelativenumber
        set nonumber
    else
        set number
        if s:relnum
            set relativenumber
        else
            set norelativenumber
        endif
    endif
endfunction

call EvaluateNumbering()

" absolute line number in insert mode
autocmd WinLeave,InsertEnter * :let s:relnum=0 | call EvaluateNumbering()
autocmd WinEnter,InsertLeave * :let s:relnum=1 | call EvaluateNumbering()

" define commands for toggling number and relative number
command InvNu let s:nonum=!s:nonum | call EvaluateNumbering()
map <C-n> :InvNu<CR>

"---------------------------------------------------------------

" backspace over everything in insert mode
set backspace=indent,eol,start

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

" map :W to :w (just a convenience)
cabbrev W w
" map :X to :x (_never_ encrypt using vim)
cabbrev X <Nop>

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

" disable showmatch
set noshowmatch

" no need for Ex mode
map Q <nop>

" ignore case when searching
set ignorecase
" unless you have capitalized letters
set smartcase

" map ctrl-c to escape
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" start at line you last exited file from
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" read local vimrc
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim.custom"
if (filereadable(b:vim))
  execute "source ".b:vim
endif


"""""" machine local settings

if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
