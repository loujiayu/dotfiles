set nocompatible
filetype off
let mapleader=','

nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>wq :wa<CR>:q<CR>
nmap <Leader>Q :qa!<CR>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

"" Track the engine."

" filesystem tree
Plugin 'scrooloose/nerdtree'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <leader>n :NERDTreeToggle<CR>

" all lanugage support
Plugin 'sheerun/vim-polyglot'

"  Trigger configuration. Do not use <tab> if you use

Plugin 'jiangmiao/auto-pairs'

" switch between *.cpp and *.h
Plugin 'vim-scripts/a.vim'

" intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'

Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" Use the Solarized Dark theme
set t_Co=256
set background=dark
colorscheme molokai

" Make Vim more useful
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=2
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
" set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show “invisible” characters
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
" set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd

" code fold 
set foldmethod=syntax
set nofoldenable

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

function! Replace(confirm, wholeword, replace)
  wa
  let flag = ''
  if a:confirm
    let flag .= 'gec'
  else
    let flag .= 'ge'
  endif
  let search = ''
  if a:woleword
    let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
  else
    let search .= expand('<cword>')
  endif
  let replace = escape(a:replace, '/\&~')
  execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认  非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认  整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认  非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))
"  确认 整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>


" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <Leader>tl :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }