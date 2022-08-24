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
" set clipboard=unnamed
set clipboard+=unnamedplus

" plugins
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'simeji/winresizer'
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'liuchengxu/vista.vim'

Plug 'tpope/vim-fugitive'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'arzg/vim-colors-xcode'
Plug 'machakann/vim-highlightedyank'
Plug 't9md/vim-choosewin'

Plug 'tanvirtin/vgit.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()
" end packages

syntax enable
colorscheme dracula
" colorscheme xcodedark

set smartindent
set autoindent
set ruler

set autoread
set so=7 " lines to the cursor - when moving vertically using j/k

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
map m :Vista<CR>
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <Leader>O :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>W :Windows<CR>
nnoremap <silent> <leader>b :Buffers<CR>

nmap <silent><leader>w <Plug>(choosewin)

map s <Plug>(easymotion-sn)
omap s <Plug>(easymotion-sn)

" plugin options
let NERDTreeHijackNetrw=1
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:choosewin_blink_on_land = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_tabline_replace    = 1
let g:choosewin_overlay_enable = 1

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

:set list listchars=tab:>-,trail:.,extends:>
" Enter the middle-dot by pressing Ctrl-k then .M
:set list listchars=tab:\|_,trail:·
" Enter the right-angle-quote by pressing Ctrl-k then >>
:set list listchars=tab:»·,trail:·
" Enter the Pilcrow mark by pressing Ctrl-k then PI
" :set list listchars=tab:>-,eol:¶

" setup
lua << EOF
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

require('vgit').setup({
  keymaps = {
    ['n <C-k>'] = 'hunk_up',
    ['n <C-j>'] = 'hunk_down',
    ['n <leader>gs'] = 'buffer_hunk_stage',
    ['n <leader>gr'] = 'buffer_hunk_reset',
    ['n <leader>gp'] = 'buffer_hunk_preview',
    ['n <leader>gb'] = 'buffer_blame_preview',
    ['n <leader>gf'] = 'buffer_diff_preview',
    ['n <leader>gh'] = 'buffer_history_preview',
    ['n <leader>gu'] = 'buffer_reset',
    ['n <leader>gg'] = 'buffer_gutter_blame_preview',
    ['n <leader>glu'] = 'project_hunks_preview',
    ['n <leader>gls'] = 'project_hunks_staged_preview',
    ['n <leader>gd'] = 'project_diff_preview',
    ['n <leader>gq'] = 'project_hunks_qf',
    ['n <leader>gx'] = 'toggle_diff_preference',
  }
})

EOF

