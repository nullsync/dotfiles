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
Plug 'preservim/nerdcommenter'
Plug 'simeji/winresizer'
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

Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}

Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

Plug 'RRethy/vim-illuminate'

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

require("toggleterm").setup()

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

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
