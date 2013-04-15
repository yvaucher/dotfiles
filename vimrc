" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" required for vundle
filetype off

" vundle : Vim plugin manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'

" vim-scripts repos
" Bundle 'L9'
Bundle 'pythoncomplete'

" Comments
Bundle 'The-NERD-Commenter'

set runtimepath^=~/.vim/bundle/ctrlp.vim

filetype plugin indent on     " required!

" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.
set ignorecase
set smartcase

" tabs and indent
set tw=0
set sw=4
set sts=4

set cindent
set smartindent
set autoindent
set expandtab

syntax on                           " syntax highlighing

syn sync minlines=300

set number


" Theme
colorscheme wombat256

" display tab and trailing as .
set list listchars=tab:»·,trail:.
"set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

filetype on
filetype plugin indent on    " enable loading indent file for filetype

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [BUF=%n]\ [%{&fo}]

set mouse=a
behave xterm

set backspace=indent,eol,start

" allow to save as sudo with :w!!
cmap w!! %!sudo tee > /dev/null %

set t_Co=256

" font by default for gvim
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ Book\ 9
endif

"display more context
set scrolloff=3

set visualbell

" pathogen plugin to auto load plugins in bundle folder
" https://github.com/tpope/vim-pathogen
call pathogen#infect()

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nmap <leader>a <Esc>:Ack!


au! BufRead,BufNewFile *.rml set ft=xml

map<C-F12> <ESC>:set list!<CR>
map<F12> <ESC>:set wrap!<CR>
au BufRead .irbrc set ft=ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 sts=2

au! BufRead,BufNewFile *.haml set ft=haml
au! BufRead,BufNewFile *.sass set ft=sass
au! BufRead,BufNewFile .openerprc set ft=cfg

" PgSQL
au BufNewFile,BufRead *.pgsql setf pgsql
au BufRead /tmp/psql.edit.* set syntax=pgsql

autocmd FileType python set omnifunc=pythoncomplete#Complete

vnoremap < <gv
vnoremap > >gv

"" Syntastic
"let g:syntastic_python_checker = 'pyflakes-2.6'
"let g:syntastic_check_on_open=1
""let g:syntastic_auto_loc_list=1
"let g:syntastic_loc_list_height=5
"let g:syntastic_stl_format = '[SYNTAX=%E{E:%e}%B{/}%W{W:%w}]'

set backupdir=/tmp
set directory=/tmp

set nowrap

" {{{1 folding (see :h folding)
" show all folds closed
set foldenable
" fold on markers tripple {
set foldmethod=marker
autocmd FileType c,cpp,d,perl,java,cs set foldmethod=syntax
autocmd FileType python,xml set foldmethod=indent
set foldcolumn=4
set foldlevel=0

"set foldmethod=indent
highlight Folded ctermfg=6 ctermbg=0
highlight FoldColumn ctermfg=6 ctermbg=0

map gf :tabedit <cfile><CR>

python << EOL
import vim
import sys
import os
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'), globals())
def CheckPy():
    eval(compile('\n'.join(vim.current.buffer), '', 'exec'), globals()) 
sys.path.append("/usr/local/lib/python2.6/site-packages")
EOL

map <C-h> :py EvaluateCurrentRange()
map <C-j> :py CheckPy()

map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>
map <C-Down> <C-e>
map <C-Up> <C-y>
noremap <A-S-Left> <C-w><
noremap <A-S-Right> <C-w>>
noremap <A-S-Up> <C-w>+
noremap <A-S-Down> <C-w>-
noremap <silent><C-S-Left> :execute 'tabmove ' . (tabpagenr()-2)<CR>
noremap <silent><C-S-Right> :execute 'tabmove ' . tabpagenr()<CR>

map <M-q> :bd<CR>

cabbr tb tab ball
cabbr td tab delete

"for activate the page down, up, etc, please comment the line below
"map <Left> <Esc>
"map <Down> <Esc>
"map <Up> <Esc>
"map <Right> <Esc>
"imap <Left> <Esc>
"imap <Down> <Esc>
"imap <Up> <Esc>
"imap <Right> <Esc>

"
" Uncomment this if you want to use pylint checker when you save your file
"
autocmd FileType python compiler pylint
"
" Above is realized with :Pylint command. To disable calling Pylint every
" time a buffer is saved put into .vimrc file
"
let g:pylint_onwrite = 0
"
" Displaying code rate calculated by Pylint can be avoided by setting
"
"     let g:pylint_show_rate = 0
"
" Openning of QuickFix window can be disabled with
"
"     let g:pylint_cwindow = 0

"
" uncomment this if you want use the 79 character max
"
autocmd FileType python highlight OverLength ctermbg=darkgrey guibg=#592929
autocmd FileType python match OverLength /\%80v.*/
" If uncommented, autowrap lines at 79 chars
" autocmd FileType python set textwidth=79
"

" allow copy paste accross applications
set clipboard=unnamed

" deactivate arrows
"noremap  <Up> ""
"noremap! <Up> <Esc>
"noremap  <Down> ""
"noremap! <Down> <Esc>
"noremap  <Left> ""
"noremap! <Left> <Esc>
"noremap  <Right> ""
"noremap! <Right> <Esc>

" <Leader> is "\"... but on qwertz keyboard it's better to use "," wich is more
" accessible
:let mapleader = ","

" Stifle many interruptive prompts
set shortmess=atI

" regenerate ctags
:nnoremap <f5> :!ctags -R<CR>

let g:pep8_map='<leader>8'

nmap <F8> :TagbarToggle<CR>

if has("autocmd")
    filetype indent on
endif

:nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>

" CtrlP config
" default key mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['.ctrlp']

set wildignore+=*.po,*.pot,*.pyc

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
let Powerline_symbols = 'fancy'
