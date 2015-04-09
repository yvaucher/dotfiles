" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" required for vundle
filetype off

" {{{ vundle : Vim plugin manager
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

" snipmate dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" TextMate like snippets
Plugin 'garbas/vim-snipmate'

" replaces powerline
Plugin 'bling/vim-airline'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Table edition for Gherkin
Plugin 'junegunn/vim-easy-align'

" PEP8
Plugin 'nvie/vim-flake8'

Plugin 'majutsushi/tagbar'

" http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" Comments
Plugin 'The-NERD-Commenter'
Plugin 'pydoc.vim'
Plugin 'wombat256.vim'

call vundle#end()
" }}}

filetype plugin indent on     " required!

" <Leader> is "\"... but on dvorak keyboard it's better to use "," wich is more
" accessible
:let mapleader = ","

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

syntax sync minlines=300

set number

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [BUF=%n]\ [%{&fo}]

set mouse=a
behave xterm

set backspace=indent,eol,start

" allow to save as sudo with :w!!
cmap w!! %!sudo tee > /dev/null %

" {{{ Theme
set t_Co=256

" font by default for gvim
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ Book\ 9
endif

let g:airline_powerline_fonts = 1
colorscheme wombat256mod

" display tab as » and trailing as .
set list listchars=tab:»·,trail:.

"display more context
"
set scrolloff=3

set visualbell

" don't wrap long lines
set nowrap

" Transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" }}}



" {{{ Filtypes
autocmd FileType python highlight OverLength ctermbg=darkgrey guibg=#592929
autocmd FileType python match OverLength /\%80v.*/

autocmd FileType xml setlocal shiftwidth=2 tabstop=2 sts=2

autocmd BufRead .irbrc set ft=ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 sts=2

autocmd! BufRead,BufNewFile *.rml set ft=xml
autocmd! BufRead,BufNewFile *.haml set ft=haml
autocmd! BufRead,BufNewFile *.sass set ft=sass
autocmd! BufRead,BufNewFile .openerprc set ft=cfg

" PgSQL
autocmd BufNewFile,BufRead *.pgsql setf pgsql
autocmd BufRead /tmp/psql.edit.* set syntax=pgsql

" }}}

vnoremap < <gv
vnoremap > >gv

set backupdir=/tmp
set directory=/tmp

" {{{ folding (see :h folding)
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

"toggle fold with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" }}}

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nmap <leader>a <Esc>:Ack!


python << EOL
import vim
import sys
import os
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'), globals())
def CheckPy():
    eval(compile('\n'.join(vim.current.buffer), '', 'exec'), globals())
sys.path.append("/usr/local/lib/python2.7/site-packages")
EOL

map <C-h> :py EvaluateCurrentRange()
map <C-j> :py CheckPy()


" {{{ Vim Tabs and windows

map gf :tabedit <cfile><CR>

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

" }}}

" allow copy paste accross applications
set clipboard=unnamed


" Stifle many interruptive prompts
set shortmess=atI

" regenerate ctags
:nnoremap <f5> :!ctags -R<CR>

let g:pep8_map='<leader>8'

nmap <F8> :TagbarToggle<CR>

:nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>

" CtrlP config
" default key mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_max_height = 30

set wildignore+=*.po,*.pot,*.pyc
