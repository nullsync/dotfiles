set nocompatible
set encoding=UTF-8
set ttyfast
set t_Co=256
set gcr=a:blinkon0              "Disable cursor blink

# neovim cursor
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

Plug 'mhartington/formatter.nvim'
Plug 'mcauley-penney/tidy.nvim'

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

nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

map <leader>r :NERDTreeFind<cr>

" plugin options
let NERDTreeHijackNetrw=1
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:choosewin_blink_on_land = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_tabline_replace    = 1
let g:choosewin_overlay_enable = 1

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
vim.o.wildmenu = on

require('vgit').setup({
  keymaps = {
    ['n <C-k>'] = 'hunk_up',
    ['n <C-j>'] = 'hunk_down',
    ['n <leader>gs'] = 'buffer_hunk_stage',
    ['n <leader>gr'] = 'buffer_hunk_reset',
    ['n <leader>vp'] = 'buffer_hunk_preview',
    ['n <leader>gb'] = 'buffer_blame_preview',
    ['n <leader>gf'] = 'buffer_diff_preview',
    ['n <leader>vh'] = 'buffer_history_preview',
    ['n <leader>gu'] = 'buffer_reset',
    ['n <leader>gg'] = 'buffer_gutter_blame_preview',
    ['n <leader>glu'] = 'project_hunks_preview',
    ['n <leader>gls'] = 'project_hunks_staged_preview',
    ['n <leader>gd'] = 'project_diff_preview',
    ['n <leader>gq'] = 'project_hunks_qf',
    ['n <leader>vx'] = 'toggle_diff_preference',
  }
})

require('tidy').setup()

-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

EOF
