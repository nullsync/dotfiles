set nocompatible
set encoding=utf-8
set ttyfast
set t_Co=256
set gcr=a:blinkon0              "Disable cursor blink

so ~/.config/nvim/plugins.vim

set smartindent
set autoindent
set ruler

" set clipboard=unnamed
set clipboard+=unnamedplus

set autoread
set so=7 " lines to the cursor - when moving vertically using j/k

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" noremap <Space> <nop>
let mapleader = "\<Space>"
" let mapleader = "`"

set showtabline=2

set nonumber
set nobackup
set nowritebackup
set nowb
set noswapfile

set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

set list
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set nofoldenable

filetype plugin indent on

" netrw config
let g:netrw_menu = 0
let g:netrw_banner = 0
let g:netrw_preview = 1
let g:netrw_liststyle = 'thin'
" let g:netrw_hide = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist


noremap <F2> :Autoformat<CR>
set pastetoggle=<F5>
set diffopt=vertical

let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1

so ~/.config/nvim/settings/nerdtree.vim
so ~/.config/nvim/settings/fzf.vim
so ~/.config/nvim/settings/key_mappings.vim
so ~/.config/nvim/settings/ctrp.vim
so ~/.config/nvim/settings/tagbar.vim
so ~/.config/nvim/settings/gitgutter.vim
" so ~/.config/nvim/settings/deoplete.vim
so ~/.config/nvim/settings/coc.vim
so ~/.config/nvim/settings/denite.vim
so ~/.config/nvim/settings/airline.vim
so ~/.config/nvim/settings/choosewin.vim

let g:gutentags_ctags_tagfile='.git/tags'

set termguicolors
" set background=light
" color gruvbox-material
color dracula

let g:syntastic_quiet_messages = { "!level": "errors" }

" Kills Trailing Whitespaces
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

aug AutoloadVimrc
  au!
  au BufWritePost init.vim source ~/.config/nvim/init.vim
aug END

