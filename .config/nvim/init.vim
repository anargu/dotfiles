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

" File browser 
Plug 'kyazdani42/nvim-tree.lua', { 'branch': 'master' }

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
" OneDark
Plug 'navarasu/onedark.nvim'
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
" catppuccin
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
" END Themes

" Telescope file finder / picker
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" neovim plugins to make it more like an IDE 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
" show warnings, docs but prettier
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

Plug 'onsails/lspkind-nvim'

Plug 'ray-x/lsp_signature.nvim'

" completion
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-calc'
Plug 'David-Kunz/cmp-npm'

Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

Plug 'rafamadriz/friendly-snippets'

" Commenting
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'terrortylor/nvim-comment'
Plug 'numToStr/Comment.nvim'

Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

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
Plug 'akinsho/toggleterm.nvim'

"Plug 'xiyaowong/nvim-transparent'

" Misc

" Zen Mode
Plug 'folke/zen-mode.nvim'

Plug 'folke/twilight.nvim'

Plug 'folke/todo-comments.nvim'

Plug 'nathom/filetype.nvim'

Plug 'karb94/neoscroll.nvim'

Plug 'windwp/nvim-autopairs'

Plug 'glepnir/dashboard-nvim'

Plug 'akinsho/bufferline.nvim'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }

Plug 'AndrewRadev/splitjoin.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'famiu/bufdelete.nvim'

" Plug 'luukvbaal/nnn.nvim'

"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python -m chadtree deps'}

" Golang
Plug 'ray-x/go.nvim'


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


" set mouse
set mouse=a
" always show the status bar
set laststatus=2

" enable 256 colors
set t_Co=256
"set t_ut= TODO I miss this value

" color schemes
set termguicolors

" let g:onedark_style = 'darker'
"set background=light
" setting colorscheme
" colorscheme palenight
" colorscheme horizon
" let g:material_style = 'lighter'
" colorscheme material
" colorscheme nightfly
" colorscheme gruvbox
" colorscheme duskfox
" colorscheme dawnfox
" colorscheme onedark
colorscheme catppuccin

function! LightTheme()
  set background=light " values dark/light
  colorscheme gruvbox
endfunction
function! DarkTheme()
  colorscheme catppuccin
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
set signcolumn=yes:1
" set signcolumn=auto
" set viminfo='25,\"50,n~/.viminfo
set tw=79

" set autoindent
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

" remap last yank
nmap ,p "0p

nmap ,P "0P


"lua << EOF
"local gitsigns = require('gitsigns')
"gitsigns.setup()
"EOF

" Format json
com! FormatJSON %!python -m json.tool

lua << EOF
  require('maps')
EOF


" Markdown Preview Plugin
" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0

" commands

command -range=% SortLinesByLength '<,'>!awk '{print length, $0}' | sort -n | sed 's/^[0-9]\+ //'

