" Commons
filetype on
filetype plugin indent on
syntax on
set rnu

set ignorecase
set smartcase

" Set \\ to toggle search highligh
nnoremap <silent> <Leader><Leader> :set hls!<CR>
map <silent> <A-Right> :bn<CR>
map <silent> <A-Left> :bp<CR>
nnoremap <silent> <Tab><Tab> :b#<CR>

" Use spaces instead of tab
set expandtab

" Tab size to 2 spaces
"
set tabstop=2
set shiftwidth=2

" VimPlug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'joshdick/onedark.vim'

Plug 'fatih/vim-go'

Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lock'}
Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

set background=dark

colorscheme onedark

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ ]


" NERDTree things
"
nmap <silent> <A-n> :NERDTreeToggle<CR>
nmap <silent> <A-1> :NERDTreeFind<CR>

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

let g:NERDTreeIgnore = [
  \ '^node_modules$',
  \ '^vendor$',
  \]

" AirLine
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='jellybeans'

" Remap keys for gotos
"
nmap <silent> <C-b> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <C-A-B> <Plug>(coc-implementation)
nmap <silent> <A-S-7> <Plug>(coc-references)

" Ctrlp
"
nnoremap <silent> <C-e> :CtrlP getcwd()<CR>
nnoremap <silent> <C-E> :CtrlPBuffer<CR>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|vendor|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" GoLang Specific Preferences
"
let g:go_def_mapping_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd FileType go nnoremap <silent> <A-cr> :GoImpl<CR>
autocmd FileType go nnoremap <silent> <A-R> :GoRename<CR>
autocmd FileType go map <silent> <C-q> :GoDoc<CR>
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4
