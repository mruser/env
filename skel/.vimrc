" Vincent Foley Bourgon's .vimrc (gnuvince@yahoo.ca)
" Severely hacked up by Joe Auricchio
" With personality of Chris Bennett

" 256 colors, it's 2012
set t_Co=256

" No compatible.  We want to use Vim, not vi
set nocp

" Give us all the good filetype stuff
filetype on
filetype indent on
filetype plugin on


set shortmess+=Is
" We don't wrap lines, they become a LONG horizontal one (useful)
" jra: yes we do. no they don't. no it isn't.
" crb: wrap when problematic
set nowrap

" always switch to the current file directory. I'll probably regret this
set autochdir

"line numbers
set number
" dont go crazy here
set numberwidth=3

" We keep 4 lines when scrolling
set scrolloff=4

" We show vertical and horizontal position
set ruler

" Little hint of what command we're in the middle of
set showcmd

" This really should be default
set showmode

" Highlight searches
set hls

" ...but don't retain search highlighting across sessions
set viminfo+=h

" and SAVE ANYTHING I PUT INTO A BUFFER, GOD DAMMIT
set viminfo+=<100000000

" Y = y$ not yy by analogy with D = d$ and C = c$
noremap Y y$

" Tilde (~) acts like an operator (like 'd' or 'c')
set top

" Incremental search
set is

" Ignore case when searching ~~~ crb - Uh no. Lets do smartcase 2007.05.30
set smartcase

" Show matching ()'s []'s {}'s
set sm

" Tabs are 8 spaces long
set tabstop=8
" When I hit tab, that's 4 spaces
set softtabstop=4
" When autoindent does a tab, it's 4 spaces long
set shiftwidth=4
set expandtab
" <tab> works cleverly
set smarttab

" let us know where the 80 edge is for herald to 1960s
" this is a vim 73ism, be prepared to remove
set colorcolumn=80
highlight ColorColumn ctermbg=232

" vfb: No need to save to make a :next :previous, etc.
" jra: I'd like to save changes only if I really want to., at least until I
"      have a real versioning filesystem
" crb: the above minus nagging on changing buffers
set hidden

" C-a and C-e go to beginning/end of line in insert mode (I hate Home and End)
" jra: I concur. And it's a big pain to type them on my laptop.
" crb: even when not in insert mode
noremap <C-a> <Home>
noremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
noremap <C-space> <C-b>
noremap <space> <C-f>

" reset resets search
nnoremap <C-L> :nohl<CR><C-L>

" functional backspace
set backspace=indent,eol,start

" No annoying bell sound
set noerrorbells

" Put title in title bar
" jra: I'd like to suppress the "thanks for flying vim" though
set title
set titleold=

" Smoother changes--we're not on a serial line these days
set ttyfast

" Tabs are converted to space characters...
set et

" ...except in Makefiles
autocmd BufRead  [mM]akefile                    set noet
autocmd BufNewFile [mM]akefile                  set noet

"...or /etc/services
autocmd BufRead /etc/services                   set noet
autocmd BufNewFile /etc/services                set noet

" ruby is 2space indents
au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2

autocmd BufNewFile *.txt                       set tw=80
autocmd BufNewFile *.txt                       set wrap
autocmd BufRead    *.txt                       set tw=80
autocmd BufRead    *.txt                       set wrap

" show tabs and trailing chars
set list
set listchars=tab:>-,trail:-
" set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•


" Jump back to the last place we were in a file
" jra: Whoever invented this is a flippin' genius. If I ever meet him/her I'll
"      take him/her out for sushi at the best place in town.
 autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal g'\"" |
\ endif

" I can type :help on my own, thanks.
noremap <F1> <Esc>

"---- syntax highlighting, autoindents, other fun stuff ----


" We put syntax highlighting (COLORS!!)
syntax on

" Set background to dark to have nicer syntax highlighting.
set background=dark

" Turn on autoindent
set ai

" Turn on smarter autoindents for C code
set cin

" Automatically insert comment leaders in carriage returns...
" and break comments at textwidth
" auto-wrapping disabled, I'll be a big boy
set formatoptions=cqro
set textwidth=80


" folds
set foldmethod=indent
set nofoldenable
set foldminlines=2
set foldlevel=99
set foldcolumn=2
function SimpleFoldText() " {
    return getline(v:foldstart).' '
endfunction " }
set foldtext=SimpleFoldText() " Custom fold text function
                                    " (cleaner than default)

" taglist
" split to the right
let Tlist_Auto_Open=0
let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exist_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
" nerdtree
let NERDTreeMinimalUI = 1
" arrow keys do weird things now
map <down> <ESC>:bn<RETURN>
map <left> <ESC>:NERDTreeToggle<RETURN>
map <right> <ESC>:Tlist<RETURN>
map <up> <ESC>:bp<RETURN>

" command line shortcuts we like now work
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ctrl + movement key for window movements
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" I'd like to create the directory structure if it isn't there
augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

"---- abbreviations and such ----
" (see also the Great Virtues of Programmers)

ab #d #define
ab #i #include

function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Allow saving of files as sudo when I forget to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Global clipboard
set clipboard=unnamed

if $SOLARIZED != ''
    if $SOLARIZED == 'dark'
        set background=dark
    else
        set background=light
    endif
    colorscheme solarized
else
    colorscheme jellybeans
endif
