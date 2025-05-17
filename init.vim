" Carlos Leonheart messy .vim

" Basic Conf
let mapleader = " "
set nocompatible
filetype plugin on
syntax on

set number relativenumber
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set nocursorline
set showmatch
set sw=2
set scrolloff=8
set history=1000
set incsearch
set nohlsearch
set ignorecase
set smartcase
set laststatus=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set updatetime=250
set background=dark
set noswapfile
set nofoldenable
set foldmethod=manual
set colorcolumn=80
set mouse=
let g:vimwiki_list = [{'path': '~/wiki/', 'syntax': 'markdown', 'ext': 'md'}]

" Plugins I need
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/calendar-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'nvim-lua/plenary.nvim'
Plug 'vimwiki/vimwiki'
Plug 'theprimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'plasticboy/vim-markdown'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'tjdevries/present.nvim', {'commit': '4e500a1'}
Plug 'epwalsh/pomo.nvim'
Plug 'rcarriga/nvim-notify'
call plug#end()

" Enable file type detection
filetype plugin indent on

" KEYMAPS
" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Searching
nnoremap <leader>pr :Rg<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>af <cmd>lua require('telescope.builtin').find_files({ cwd = '/home/korekat/personal' })<CR>

" Breaking Long Paragraphs
nnoremap <leader>pw gqap

" VimWiki
nnoremap <Leader>ww :VimwikiIndex<CR>
nnoremap <Leader>wp :VimwikiDiaryIndex<CR>
nnoremap <Leader>wo :VimwikiMakeDiaryNote<CR>
nnoremap <Leader>wt :VimwikiMakeTomorrowDiaryNote<CR>

" Explore and Calendar
nnoremap <Leader>pe :Explore<CR>  " Open file explorer
nnoremap <Leader>pc :Calendar<CR>  " Open calendar

" Disable arrow keys in normal and insert mode
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>

inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>

cnoremap <Up>    <Nop>
cnoremap <Down>  <Nop>
cnoremap <Left>  <Nop>
cnoremap <Right> <Nop>

" Autocomplete and Coc
imap <C-s> <Esc>gh
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Ensure CoC works properly inside VimWiki files
autocmd FileType vimwiki inoremap <expr> <buffer> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"

autocmd FileType vimwiki inoremap <expr> <buffer> <S-Tab>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

autocmd FileType vimwiki inoremap <expr> <buffer> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" VimWiki Conf
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:vimwiki_key_mappings = { 'global': 0 }
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown'}

" Keybingins Lua
lua require('keybindings')

" ColorScheme
highlight Normal ctermbg=NONE guibg=NONE
highlight StatusLine guifg=#ffffff guibg=#005f5f ctermfg=white ctermbg=235
colorscheme tokyonight
hi Normal guibg=#RRGGBB
highlight NormalNC guibg=NONE ctermbg=NONE
