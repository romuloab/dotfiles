" Inspired by https://github.com/ryanss/vim

set shell=/bin/bash                    " Fish'ers need this
let g:vundle_default_git_proto = 'git' " Vundle should use git:// instead of https://

" Automatically setup Vundle on first run
if !isdirectory(expand("~/.vim/bundle/vundle"))
    call system("git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle")
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'tpope/vim-surround'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/vim-easy-align'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'kurkale6ka/vim-pairs'
"Plugin 'Lokaltog/vim-easymotion'
Plugin 'othree/html5.vim'
Plugin 'rstacruz/sparkup'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/closetag.vim'
Plugin 'vim-scripts/PHP-correct-Indenting'
Plugin 'nanotech/jellybeans.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/Align'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'Shougo/unite.vim'
Plugin 'spolu/dwm.vim'
" Don't forget to `pip install neovim` with python2 (python3 doesn't work)
Plugin 'joonty/vdebug'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'FooSoft/vim-argwrap'

" Automatically install bundles on first run
if !isdirectory(expand("~/.vim/bundle/vim-airline"))
    execute 'silent PluginInstall'
    execute 'silent q'
endif

filetype plugin indent on
syntax on
colorscheme jellybeans

set autoread                " auto reload buffer when file modified externally
if !has('nvim')
    set encoding=utf-8          " default character encoding
endif
set hidden                  " do not unload buffers that get hidden
set noswapfile              " do not use a swap file for buffers
set nowritebackup           " do not make backup before overwriting file
set mouse=a                 " enable mouse when available
set nostartofline           " don't move the cursor to the start of the line with G,gg etc

set laststatus=2            " always show the status line
set nowrap                  " do not wrap text
set number                  " show line numbers
set scrolloff=3             " keep at least 3 lines above/below cursor
set sidescrolloff=3         " keep at least 3 columns left/right of cursor
set showcmd                 " show command line at bottom of screen
set splitright              " open vertical split right of current window
set visualbell              " use visual bell instead of beeping
set wildmenu                " tab auto-complete for commands
set wildignore=*~,*.o,*.obj,*.luac

set backspace=2             " make backspace behave normally
set expandtab               " insert tabs as spaces
set shiftwidth=4            " number of spaces for auto indent and line shift
set cindent                 " syntax-aware auto indent
set smarttab                " <BS> deletes a shiftwidth worth of space
set softtabstop=4           " number of spaces pressing <Tab> counts for
set tabstop=4               " number of spaces a <Tab> in the file counts for

set ignorecase              " ignore case when pattern matching
set smartcase               " only if all characters are lower case
set incsearch               " highlight matches while typing search
set hlsearch                " keep previous search highlighted

set tabpagemax=100          " increase 'vim -p' page count limit to 100
set list                    " show tabs and trailling spaces
set listchars=tab:→‧,trail:‧

" Thank me later
nmap <silent> <space> :nohlsearch<cr>
noremap ; :

let mapleader = ","
let g:mapleader = ","

" Git/fugitive shortcuts
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
vnoremap <Leader>gb :Gblame<CR>

" Ack
nmap <Leader>aa :Ack! <cword><CR>
if executable('pt')
    let g:ackprg = 'pt'
endif

nnoremap <Leader>gf <C-W>h<C-W>czR
nnoremap <Leader>TP :tabmove -1<CR>
nnoremap <Leader>TN :tabmove +1<CR>

" It seems CtrlP is messing with fugitive. This should fix.
" au BufReadPost fugitive://* set bufhidden=delete

" <nul> is <c-space>, but actually works
map <nul> <Plug>(easymotion-s2)
map <Leader>a <Plug>(EasyAlign)

" Shortcuts to edit and reload vim config
nnoremap <Leader>r :edit ~/.vimrc<CR>
nnoremap <Leader>R :source ~/.vimrc<CR>:source ~/.vimrc<CR>

" Don't forget to install Liberation Mono Powerline
let g:airline_powerline_fonts = 1
let g:airline_section_y = airline#section#create(['%p', '%%'])
let g:airline_section_z = airline#section#create_right(['%l %c'])

" Closetag settings
let g:closetag_html_style=1
autocmd! FileType html,htmldjango source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" Use JSX syntax on .js files too
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1

" Highlight characters when lines get too long
autocmd! BufWinEnter *.py,*.vim,vimrc match ErrorMsg '\%>79v.\+'
autocmd! BufWinEnter *.html match ErrorMsg '\%>100v.\+'

"nmap <c-p> :FZF
nmap <c-p> :GitFile<CR>
nmap <c-g> :BTags<CR>
nmap <c-f> :Tags<CR>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

" \ 'return': 'tab split',
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" CtrlP
" nmap ^_ :CtrlP<cr>
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_max_files = 0
" let g:ctrlp_user_command = '~/.vim/ctrlp_find.sh %s'
" let g:ctrlp_prompt_mappings = {'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
"                               \'AcceptSelection("t")': ['<cr>']}


" Synthastic
let g:syntastic_javascript_checkers = ['eslint']
" For JSX files, we want to use a special linter that handles XML tags inline
autocmd! BufWinEnter *.jsx,*.react.js let g:syntastic_javascript_checkers = ['jsxhint']

" When in XML file, let's use a proper identation prog (libxml2-utils)
autocmd! BufWinEnter *.xml set equalprg=xmllint\ --format\ -

" Expands %% to current file's directory
" Type ":e %%/" to expand to ":e /path/of/this/file/"
cabbr <expr> %% expand('%:p:h')

" Inserts uuid under cursor
nmap <leader>u "=system('echo -n `uuid -v 4`')<cr>p
nmap <leader>U "=system('echo -n `uuid -v 4`')<cr>P
nmap ciu ciq<c-o><leader>u<esc>

nmap gy gT
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap gf :tabnew <cfile><cr>

" Replaces the last yanked selection with the visual selection
vnoremap <C-X> <Esc>`.``gvP``P

" Visual select last pasted text (a la gv):
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Sends the current visual to the external program `pbcopy` without changing
" the buffer.
vmap <leader>c <esc>:'<,'>:w !pbcopy<CR>

nnoremap <leader>v :read !pbpaste<CR>
vmap <leader>v "_R<esc>:'<,'>-1read !pbpaste<CR>

" Strips all trailling whitespace
nmap <leader>ss :%s/ \+$//g<cr>

nnoremap <silent> <leader>aw :ArgWrap<CR>

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go set nolist
au FileType go let g:argwrap_tail_comma = 1

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

autocmd BufWritePost *.php exec system("/source/ctags/ctags -a --fields=+aimS --languages=php <cfile>")

let g:vdebug_options = {
            \"server": "localhost",
            \"timeout": 10,
            \"ide_key": "",
            \"port": 9001,
            \}
