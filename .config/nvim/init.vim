" Set <leader> key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

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

Plug 'ray-x/lsp_signature.nvim'

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

"Plug 'xiyaowong/nvim-transparent'

" Misc
Plug 'Pocco81/TrueZen.nvim'

Plug 'nathom/filetype.nvim'

Plug 'karb94/neoscroll.nvim'

Plug 'windwp/nvim-autopairs'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'glepnir/dashboard-nvim'

Plug 'romgrk/barbar.nvim'

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
" hi Normal guibg=none ctermbg=none
" hi NonText guibg=none ctermbg=none
" hi LineNr guibg=none ctermbg=none
" hi Folded guibg=none ctermbg=none
" "hi SpecialKey guibg=none ctermbg=none
" hi VertSplit guibg=none ctermbg=none
" hi SignColumn guibg=none ctermbg=none
"hi EndOfBuffer guibg=none ctermbg=none


" save file
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Linux\n"
    nmap <c-s> :w<CR>
    imap <c-s> <Esc>:w<CR>
  endif
  if s:uname == "Darwin\n"
    nmap <D-s> :w<CR>
    imap <D-s> <Esc>:w<CR>
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

" Format json
com! FormatJSON %!python -m json.tool

