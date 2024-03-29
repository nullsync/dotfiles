set nocompatible
set encoding=UTF-8
set ttyfast
set t_Co=256
set gcr=a:blinkon0              "Disable cursor blink

" neovim cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

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
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'simeji/winresizer'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'liuchengxu/vista.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'

"Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'arzg/vim-colors-xcode'
Plug 'machakann/vim-highlightedyank'
Plug 't9md/vim-choosewin'

Plug 'tanvirtin/vgit.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }

Plug 'mcauley-penney/tidy.nvim'

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'hashivim/vim-terraform'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

Plug 'RRethy/vim-illuminate'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" end packages

call wilder#setup({'modes': [':', '/', '?']})

syntax enable
" colorscheme dracula
colorscheme xcodedark

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

set completeopt=menu,menuone,noselect

let g:highlightedyank_highlight_duration = 1000

" key mappings
let mapleader = "\<Space>"
map <leader>n :NERDTreeToggle<CR>
map m :Vista!!<CR>
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

map <leader>r :NERDTreeFind<cr>
map - :edit %:h<cr>

" plugin options
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

let NERDTreeHijackNetrw=1
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:choosewin_blink_on_land = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_tabline_replace    = 1
let g:choosewin_overlay_enable = 1

set list listchars=tab:>-,trail:.,extends:>
" Enter the middle-dot by pressing Ctrl-k then .M
set list listchars=tab:\|_,trail:·
" Enter the right-angle-quote by pressing Ctrl-k then >>
set list listchars=tab:»·,trail:·
" Enter the Pilcrow mark by pressing Ctrl-k then PI
" set list listchars=tab:>-,eol:¶
"
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

" setup
lua << EOF
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'
vim.o.wildmenu = on

require('vgit').setup({
  keymaps = {
    ['n <C-k>'] = 'hunk_up',
    ['n <C-j>'] = 'hunk_down',
    ['n <leader>vs'] = 'buffer_hunk_stage',
    ['n <leader>vr'] = 'buffer_hunk_reset',
    ['n <leader>vp'] = 'buffer_hunk_preview',
    ['n <leader>vb'] = 'buffer_blame_preview',
    ['n <leader>vf'] = 'buffer_diff_preview',
    ['n <leader>vh'] = 'buffer_history_preview',
    ['n <leader>vu'] = 'buffer_reset',
    ['n <leader>vg'] = 'buffer_gutter_blame_preview',
    ['n <leader>vlu'] = 'project_hunks_preview',
    ['n <leader>vls'] = 'project_hunks_staged_preview',
    ['n <leader>vd'] = 'project_diff_preview',
    ['n <leader>vq'] = 'project_hunks_qf',
    ['n <leader>vx'] = 'toggle_diff_preference',
  },
  live_gutter = {
    enabled = true,
    edge_navigation = true,
  },
  settings = {
    scene = {
      diff_preference = 'split',
    }
  }
})

require('tidy').setup()

require("toggleterm").setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
})

EOF
