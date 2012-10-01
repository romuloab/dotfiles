" An example for a vimrc file.
"
" Maintainer:        Bram Moolenaar <Bram@vim.org>
" Last change:        2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"              for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"            for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable syntax auto detection
filetype plugin indent on
syntax enable

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup                " do not keep a backup file, use versions instead
else
  set backup                " keep a backup file
endif
set ruler                " show the cursor position all the time
set showcmd                " display incomplete commands
set incsearch                " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running") || has('gui')
  syntax on
  set hlsearch
  set t_Co=256
  colorscheme wombat256
endif
  syntax on
  set hlsearch
  set t_Co=256
  colorscheme wombat256

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                 \ | wincmd p | diffthis

set sts=4
set expandtab
set shiftwidth=4

let lua_version = 5
let lua_subversion = 1

let maplocalleader=','          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
set wildignore=*~,*.o,*.obj
set scrolloff=5                 " keep at least 5 lines above/below cursor
set sidescrolloff=5             " keep at least 5 columns left/right of cursor
set history=2000                " remember the last 2000 commands

nmap q: :q
nmap gy gT
cabbr aa Align
imap <C-Enter> <esc>O
nmap <C-Enter> <esc>O

"set gfn=Consolas:h14
set gfn=Monaco:h14
set number
set textwidth=0
"autocmd FileType c,cpp,lua autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

let g:Align_xstrlen=2

au BufRead * :exe "set expandtab"
au BufRead *.html :exe "set ft=htmldjango"
au BufRead *.html :exe "set indentexpr=off"
au BufRead *.html :exe "set autoindent"
"au BufRead *.lua :exe "LuaInspect"
au BufNewFile,BufRead *.nyx setf lua
