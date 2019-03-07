" {{{ vundle : Vim plugin manager

" required for vundle
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")

" let Vundle manage Vundle, required!
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

" TextMate like snippets
Plugin 'SirVer/ultisnips'
" Repo of common snippets
Plugin 'honza/vim-snippets'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Super tab to make YCM and UltiSnips collaborate
Plugin 'ervandew/supertab'

" replaces powerline
Plugin 'vim-airline/vim-airline'

" Table edition for Gherkin
Plugin 'junegunn/vim-easy-align'

" PEP8 + pylint
" Async syntax checker for NeoVim and Vim 8
" A tool that goes snicker-snack on the bad syntax
Plugin 'w0rp/ale'

" http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" Comments
Plugin 'The-NERD-Commenter'
Plugin 'pydoc.vim'
Plugin 'wombat256.vim'

call vundle#end()
filetype plugin indent on     " required!
" }}}


" <Leader> is "\"... but on dvorak keyboard it's better to use "," wich is more
" accessible
:let mapleader = ","

" Search {{{
" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.
set ignorecase
set smartcase
" }}}

" tabs and indent
set tw=0
set sw=4
set sts=4

set cindent
set smartindent
set autoindent
set expandtab

syntax on                           " syntax highlighing

" Set hightlighting start on more than the default 50 lines
" especially for long docstring that mess with the highlight
syntax sync minlines=400

set number

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [BUF=%n]\ [%{&fo}]

set mouse=a
behave xterm

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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

" allow copy paste accross application
set clipboard+=unnamed

" Stifle many interruptive prompts
set shortmess=atI

" regenerate ctags
:nnoremap <f5> :!ctags -R<CR>

nmap <F8> :TagbarToggle<CR>

:nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>


set wildignore+=*.po,*.pot,*.pyc
set wildmenu

" Plugins {{{

" YCM {{{
" make YCM compatible with UltiSnips (using supertab)
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme/22253548#22253548
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:SuperTabDefaultCompletionType = '<C-tab>'
" }}}

" UltiSnips {{{
let g:UltiSnipsExpendTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<Right>"
let g:UltiSnipsJumpBackwardTrigger = "<Left>"
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'myUltiSnips']

let g:snips_author = 'Yannick Vaucher'
let g:snips_email = 'yannick.vaucher@camptocamp.com'
let g:snips_company = 'Camptocamp'
let g:snips_full_company = 'Camptocamp SA'
let g:snips_company_website = 'www.camptocamp.com'
" }}}

" }}}
