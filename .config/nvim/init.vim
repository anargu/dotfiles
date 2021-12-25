" Set <leader> key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"
" let mapleader = ";"

" https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4
" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let need_to_install_plugins = 1
endif

call plug#begin()
" Utils
" vim surround
Plug 'tpope/vim-surround'

" File browser with git indicators
Plug 'preservim/nerdtree'
Plug 'vim-scripts/The-NERD-tree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" git indicator in editor
Plug 'lewis6991/gitsigns.nvim'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" otherwise use:
" Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'
" END Git tools

" Status Line
Plug 'nvim-lualine/lualine.nvim'
" icons for status line
Plug 'kyazdani42/nvim-web-devicons'

" Themes
" Nord theme
Plug 'arcticicestudio/nord-vim'
" Oceanic Next
Plug 'mhartington/oceanic-next'
" Palenight
Plug 'drewtempelmeyer/palenight.vim'
" Horizon
Plug 'ntk148v/vim-horizon'
" Night Owl.vim
Plug 'haishanh/night-owl.vim'
" nightfly
Plug 'bluz71/vim-nightfly-guicolors'
" Material
Plug 'marko-cerovac/material.nvim'
" Gruvbox
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
" nightfox
Plug 'EdenEast/nightfox.nvim'
" END Themes

" Telescope file finder / picker
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" neovim plugins to make it more like an IDE 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
" show warnings, docs but prettier
Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }
" completion
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" Nicer LSP UI
" Plug 'glepnir/lspsaga.nvim'
"Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim51' }

" Commenting
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'terrortylor/nvim-comment'
Plug 'numToStr/Comment.nvim'

" Completion
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'

" For luasnip users.
"Plug 'L3MON4D3/LuaSnip'
"Plug 'saadparwaiz1/cmp_luasnip'

" JS(X), TS(X)
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'jparise/vim-graphql'
" Plug 'maxmellon/vim-jsx-pretty' 
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" web
"Plug 'skammer/vim-css-color'
Plug 'mattn/emmet-vim'

" terminal
"Plug 'akinsho/toggleterm.nvim'

" Liquid syntax
"Plug 'tpope/vim-liquid'
" jinja syntax
"Plug 'lepture/vim-jinja'

"Plug 'xiyaowong/nvim-transparent'
call plug#end()

" copy clipboard
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n" || s:uname == "Linux\n"
    " Use OSX clipboard to copy and to paste
    set clipboard+=unnamedplus
    " Copy selected text in visual mode
    "set clipboard+=autoselect
  endif
endif

filetype plugin indent on
syntax on
" syntax enable

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif


" always show the status bar
set laststatus=2

" enable 256 colors
set t_Co=256
"set t_ut= TODO I miss this value

" color schemes
set termguicolors

"set background=light
" setting colorscheme
" colorscheme palenight
" colorscheme horizon
" let g:material_style = 'lighter'
" colorscheme material
"colorscheme nightfly
"colorscheme gruvbox
colorscheme nightfox

function! LightTheme()
  set background=light
  colorscheme gruvbox
endfunction
function! DarkTheme()
  colorscheme nightfox
endfunction

lua << EOF
--require 'colorizer'.setup {
--  'css';
--  'javascript';
--  'sass';
--  'scss';
--}
EOF

" setting airline theme
"let g:lightline = {
"     \ 'colorscheme': 'palenight',
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ],
"     \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"     \ },
"     \ 'component_function': {
"     \   'gitbranch': 'fugitive#Head'
"     \ },
"      \ }



" open new split panes to right and below
set splitright
set splitbelow

set hidden
" turn on line numbering
set number

" turn relative line numbers on
set relativenumber
set rnu

" Display long lines as just one line
set nowrap 

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" sane editing
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set colorcolumn=80
"set signcolumn=yes:2
" set viminfo='25,\"50,n~/.viminfo
set tw=79
set autoindent
set smartindent

" Transparent background
hi Normal guibg=none ctermbg=none
hi NonText guibg=none ctermbg=none
hi LineNr guibg=none ctermbg=none
hi Folded guibg=none ctermbg=none
"hi SpecialKey guibg=none ctermbg=none
hi VertSplit guibg=none ctermbg=none
hi SignColumn guibg=none ctermbg=none
"hi EndOfBuffer guibg=none ctermbg=none

" save file
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Linux\n"
    nmap <c-s> :w<CR>
    imap <c-s> <Esc>:w<CR>
  endif
endif

" highlighting large files in JS, JSX, TS, TSX
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" file browser
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <leader>t :call NERDTreeToggle()<CR>
"
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

function NERDTreeToggle()
    "NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
        NERDTreeFind
    endif
endfunction

"function! NERDTreeToggle()
"  if CheckIfCurrentBufferIsFile()
"    if IsNERDTreeOpen()
"      NERDTreeClose
"    else
"      NERDTreeFind
"    endif
"  else
"    NERDTree
"  endif
"endfunction

" Highlight currently open buffer in NERDTree
"autocmd BufRead * call SyncTree()

let NERDTreeShowHidden=1
" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"


" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"nnoremap <Leader>o o<Esc>^Da
"nnoremap <Leader>O O<Esc>^Da

" key map to save file with Cmd + s
" map <D-s> :w<kEnter>  "Works in normal mode, must press Esc first"
" imap <D-s> <Esc>:w<kEnter>i "Works in insert mode, saves and puts back in insert mode"



" Fugitive configuration
"cnoreabbrev g Git
cnoreabbrev gopen GBrowse
" Signify
" Change these if you want
" if want to disable Signify then uncomment line below
" let g:loaded_signify = 0

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
" GitSigns

"lua << EOF
"local gitsigns = require('gitsigns')
"gitsigns.setup()
"EOF

" Lazygit configuration
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters

let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed
"
" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>



" lspsaga plugin configuration
lua << EOF
--local saga = require('lspsaga')
--
--saga.init_lsp_saga {
--  error_sign = "",
--  warn_sign = "",
--hint_sign = "",
--infor_sign = "",
--dianostic_header_icon = "   ",
--border_style = "round",
  
  -- code action title icon
--  code_action_icon = " ",
--  code_action_prompt = {
--    enable = true,
--    sign = true,
--    sign_priority = 40,
--    virtual_text = true,
--  },
--}
EOF

" jump diagnostic
"nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
"nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
" hover doc
"nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" find definition and references
"nnoremap <silent> gh :Lspsaga lsp_finder<CR>
" preview definition
"nnoremap <silent> gp :Lspsaga preview_definition<CR>
" code action
"nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
"vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" rename
"nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
" lspsaga END


lua << EOF
-- get colors from Nightfox to use in the words count
local nfColors = require("nightfox.colors").init("nordfox")

require'lualine'.setup {
  options = {
    theme = "nightfox",
    --theme = "gruvbox"
    --theme = "material-nvim"
    icons_enabled = true,
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    --component_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = { 'FugitiveHead' },
    lualine_b = { {'diagnostics', sources={'nvim_lsp', 'coc'}} },
  }
}
EOF

" nvim.comment
lua << EOF
require('Comment').setup({
  ---Add a space b/w comment and the line
  ---@type boolean
  padding = true,

  ---Whether the cursor should stay at its position
  ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
  ---@type boolean
  sticky = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|function
  ignore = nil,

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
      ---line-comment keymap
      line = 'gcc',
      ---block-comment keymap
      block = 'gcb',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
      ---line-comment keymap
      line = 'gc',
      ---block-comment keymap
      block = 'gb',
  },

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---@type table
  mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
  },

  ---Pre-hook, called before commenting the line
  ---@type function
  pre_hook = nil,

  ---Post-hook, called after commenting is done
  ---@type function
  post_hook = function(ctx)
      -- Only calculate commentstring for tsx filetypes
      if vim.bo.filetype == 'typescriptreact' then
          local U = require('Comment.utils')

          -- Detemine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.block then
              location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring({
              key = type,
              location = location,
          })
      end
    end,
})

-- equire('nvim_comment').setup({
--  -- Linters prefer comment and line to have a space in between markers
--  marker_padding = true,
--  -- should comment out empty or whitespace only lines
--  comment_empty = true,
--  -- Should key mappings be created
--  create_mappings = true,
--  -- Normal mode mapping left hand side
--  line_mapping = "<leader>cc",
--  -- Visual/Operator mapping left hand side
--  operator_mapping = "<leader>gc",
--  -- Hook function to call before commenting takes place
--  hook = function()
--    require("ts_context_commentstring.internal").update_commentstring()
--    -- if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
--    --   require("ts_context_commentstring.internal").update_commentstring()
--    -- end
--  end
-- })

EOF

" Format json
com! FormatJSON %!python -m json.tool

