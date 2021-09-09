set nocompatible
set encoding=UTF-8
set ttyfast
set t_Co=256
set gcr=a:blinkon0              "Disable cursor blink

" set ttimeout for faster cursor changes
set ttimeout
set ttimeoutlen=100

set showcmd
set wildmenu

set number
set clipboard=unnamed

" packages
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'preservim/nerdtree'
Plug 'simeji/winresizer'
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'arzg/vim-colors-xcode'
Plug 'machakann/vim-highlightedyank'

call plug#end()
" end packages

syntax enable
colorscheme dracula
" colorscheme xcodedark

set smartindent
set autoindent
set ruler

set autoread
" set so=7 " lines to the cursor - when moving vertically using j/k

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" no editor files
set nobackup
set nowb
set noswapfile

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set nofoldenable

let g:highlightedyank_highlight_duration = 1000

" key mappings 
let mapleader = "\<Space>"
map <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <Leader>O :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>

map s <Plug>(easymotion-sn)
omap s <Plug>(easymotion-sn)

map n <Plug>(easymotion-next)
map N <Plug>(easymotion-next)

" plugin options
let NERDTreeHijackNetrw=1
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" tab completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set guifont=FiraCodeNerdFontComplete-Light:h18
set guioptions=

" Kills Trailing Whitespaces
" command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

:set list listchars=tab:>-,trail:.,extends:>
" Enter the middle-dot by pressing Ctrl-k then .M
:set list listchars=tab:\|_,trail:·
" Enter the right-angle-quote by pressing Ctrl-k then >>
:set list listchars=tab:»·,trail:·
" Enter the Pilcrow mark by pressing Ctrl-k then PI
" :set list listchars=tab:>-,eol:¶
