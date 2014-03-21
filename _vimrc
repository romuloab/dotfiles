if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif
if match($TERM, "screen")!=-1
    "set term=xterm
endif

set nocompatible
set backup                      " keep a backup file
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set ignorecase                  " search case-insensitive
set smartcase                   " find case-insensitive unless search term has upcase letters
set hlsearch                    " highlight search matches
set number                      " show line numbers
set mouse=a                     " In many terminal emulators the mouse works just fine, thus enable it.

set softtabstop=4
set tabstop=8
set expandtab
set shiftwidth=4
set textwidth=0                 " disable text wrap
set autoindent                  " always set autoindenting on
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

set tabpagemax=100              " increase 'vim -p' page count limit to 100

let maplocalleader=','          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
set wildignore=*~,*.o,*.obj,*.luac
set scrolloff=2                 " keep at least 2 lines above/below cursor
set sidescrolloff=2             " keep at least 2 columns left/right of cursor
set history=2000                " remember the last 2000 commands

" statusline
set laststatus=2                " always show statusline
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

"set list                        " show tabs and trailling spaces
"set listchars=tab:→‧,trail:‧

set t_Co=256

set path+=$EVN_ENV/src/**,$EVN_ENV/templates/**,$EVN_ENV/www/**

" Set the font VIM's GUIs will use. 
" TODO detect which client/os (win,linux,mac)
"set gfn=Monaco:h14
set gfn=Consolas:h14

" ~~ Plugins setup ~~

" Pathogen Plugin
call pathogen#runtime_append_all_bundles()

" LuaInspect plugin
let g:lua_inspect_events = ''  " Temporarily disable lua-inspect

" Align plugin
let g:Align_xstrlen=2
cabbr aa Align

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

endif " has("autocmd")

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
 let g:ctrlp_custom_ignore = {
   \ 'dir':  '\v([\/]\.(git|hg|svn)$)',
   \ 'file': '\v\.(exe|so|dll|.*~)$',
   \ }

let g:ctrlp_max_files = 0
let g:ctrlp_user_command = '~/.vim/ctrlp_find.sh %s'

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

nmap gy gT
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
imap <C-Enter> <esc>O
nmap <C-Enter> <esc>O

nmap <A-,> :tabprevious<CR>
nmap <A-.> :tabnext<CR>

map [D :tabprevious<CR>
map [C :tabnext<CR>
map , :tabprevious<CR>
map . :tabnext<CR>

set pastetoggle=[12~

autocmd FileType c,css,javascript,cpp,lua,html,htmldjango autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

au! Syntax less source $HOME/.vim/ftplugin/less.vim
au BufRead *.html :exe "set ft=htmldjango"
au BufRead *.html :exe "set indentexpr=off"
au BufRead *.less :exe "set ft=less"

" Because of pathogen module, syntax highlighting should be called last
" colorscheme wombat256
colorscheme mustang
filetype plugin indent on
filetype indent on
syntax enable

" Adiciona atalho pra editar arquivos no diretório do arquivo atual. 
" Digite ":e %%/" para expandir para ":e /path/do/arquivo/aberto/"
cabbr <expr> %% expand('%:p:h')