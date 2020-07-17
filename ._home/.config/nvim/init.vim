" Load VimPlug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')
  
  " General {{{
    " Behavior 
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-sleuth'
    Plug 'sickill/vim-pasta'
    Plug 'airblade/vim-gitgutter'

    set ignorecase
    set smartcase
    set incsearch
    set nolazyredraw

    set magic

    set autoindent
    set shell=$SHELL
    
    set hidden
     
    set autoread " Hot-reload files
    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamedplus " Yank to clipboard

    " Appearance
    "
    set number
    set relativenumber
    set wrap linebreak nolist
    set showbreak=^\
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    set title
    set showmatch
    set wildmenu
    set cmdheight=2
    set updatetime=300
    set shortmess+=c 
    set signcolumn=yes 

    " Theme {{{
      " Plug 'joshdick/onedark.vim'
      " Plug 'rakr/vim-one'
      Plug 'jacoborus/tender.vim'
    " }}}

    filetype on
    filetype plugin indent on
    syntax on

    " Tabs
    "
    set smarttab
    set expandtab " use spaces
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround

    " Code folding
    "
    set foldmethod=syntax
    set foldlevelstart=99
    set foldnestmax=10
    set nofoldenable
    set foldlevel=1

    " Comments
    let g:NERDDefaultAlign = 'start'
    let g:NERDSpaceDelims = 1
    let g:NERDCreateDefaultMappings = 0
    
    " AirLine {{{
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'

      let g:airline#extensions#tabline#enabled = 1
      let g:airline_theme='tender'
    " }}}
  " }}}
  
  " KeyMap {{{
    
      let mapleader = ';'

      " ;nu and ;rnu to toggle numbering
      nnoremap <silent> <leader>nu :set nu!<CR>
      nnoremap <silent> <leader>rnu :set rnu!<CR>

      nnoremap <silent> <Leader><Leader> :set hls!<CR>
      map <silent> <A-Right> :bn<CR>
      map <silent> <A-Left> :bp<CR>
      nnoremap <silent> <Tab><Tab> :b#<CR>

      nnoremap <silent> <C-j> 3<C-e>
      nnoremap <silent> <C-k> 3<C-y> 
      nnoremap <silent> <C-Down> <C-e>
      nnoremap <silent> <C-Up> <C-y>

      " Use Ctrl + / to comment
      nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
      vnoremap <C-_> :call NERDComment(0, "toggle")<CR>
  " }}}

  " NERDTree {{{
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'


    function! ToggleNerdTree()
        if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
        :NERDTreeFind
      else
        :NERDTreeToggle
      endif
    endfunction

    nmap <silent> <A-1> :call ToggleNerdTree()<CR>
    nmap <silent> <Leader>f :NERDTreeFind<CR>

    let NERDTreeAutoDeleteBuffer = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    let NERDTreeShowHidden = 1

    let g:NERDTreeIgnore = [
      \ '^node_modules$',
      \ '^vendor$',
      \ '^\.git$',
      \ '^\.idea$',
      \]  
  " }}}

  " coc {{{
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lock'}

    let g:coc_global_extensions = [
      \ 'coc-pairs',
      \ 'coc-emmet',
      \ 'coc-vimlsp',
      \ 'coc-git',
      \ 'coc-sh',
      \ 'coc-css',
      \ 'coc-tsserver',
      \ 'coc-tslint-plugin',
      \ ]

    nmap <silent> <C-b> <Plug>(coc-definition)
    nmap <silent> <C-t> <Plug>(coc-type-definition)
    nmap <silent> <C-A-B> <Plug>(coc-implementation)
    nmap <silent> <A-S-7> <Plug>(coc-references)

    " coc prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile
    nmap <silent> <C-A-l> :CocCommand prettier.formatFile<CR>

    nmap <silent> <C-A-l> <Plug>(coc-format-selected)
    xmap <silent> <C-A-l> <Plug>(coc-format-selected)

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
  " }}}"

  " ctrlp {{{
    Plug 'ctrlpvim/ctrlp.vim'

    nnoremap <silent> <C-p> :CtrlP getcwd()<CR>

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn|vendor|node_modules)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }
  " }}}

  " Fugitive {{{
    Plug 'tpope/vim-fugitive'

    nmap <silent> <leader>gs :Gstatus<cr>
    nmap <leader>ge :Gedit<cr>
    nmap <silent><leader>gr :Gread<cr>
    nmap <silent><leader>gb :Gblame<cr>
  " }}}

  " Language Specific {{{
    " Go {{{
      Plug 'fatih/vim-go'

      " Syntax
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
      autocmd FileType go map <silent> <C-A-l> :GoFmt<CR>:GoImports<CR>

      " Debugging 
      let g:go_debug_windows = {
        \ 'vars': 'rightbelow 40vnew',
        \ 'out': 'below 20 new',
        \}

      autocmd FileType go nnoremap <F8> :GoDebugNext<CR>
      autocmd FileType go nnoremap <F7> :GoDebugStep<CR>
      autocmd FileType go nnoremap <F6> :GoDebugStepOut<CR>

      autocmd FileType go nnoremap <F33> :GoDebugStart<CR>
      autocmd FileType go nnoremap <F34> :GoDebugTest<CR>

      autocmd FileType go nnoremap <A-S-8> :GoDebugPrint 
    " }}}
    
    " vimrc {{{
      let g:NERDDefaultAlign = 'none'
    " }}}

    " Javascript {{{
      Plug 'pangloss/vim-javascript'    

      if isdirectory('./node_modules')

        if isdirectory('./node_modules/prettier')
          let g:coc_global_extensions += ['coc-prettier']
        elseif isdirectory('./node_modules/eslint')
          let g:coc_global_extensions += ['coc-eslint']
        endif

      endif

      autocmd FileType javascript nnoremap <A-cr> <Plug>(coc-codeaction)
      autocmd FileType javascript nnoremap <silent> <C-o> :CocList -I symbols<CR>
    " }}}
    
    " TypeScript {{{
      Plug 'peitalin/vim-jsx-typescript'
      Plug 'leafgarland/typescript-vim'
      " Plug 'Shougo/vimproc.vim', { 'do': 'make' } TODO what still needs this?
    " }}}
    
    " Presenting {{{
      Plug 'sotte/presenting.vim'
    " }}}
    
    " GraphQL {{{
      Plug 'jparise/vim-graphql'
    " }}}

    " MarkDown {{{
      autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
      autocmd FileType markdown set spell
      autocmd FileType markdown nnoremap <silent> <Leader>pdf :w<CR>    
    " }}}

    " XML {{{
      autocmd FileType xml vnoremap <silent> <C-A-l> :!xmllint --format -<CR>
    " }}}
  " }}}
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" These calls must be after plug#end() to ensure that theme loads
set background=dark
colorscheme tender
