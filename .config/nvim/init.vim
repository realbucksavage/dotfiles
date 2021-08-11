" Load VimPlug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')
  
  " General {{{
    " Behavior 
    Plug 'chr4/nginx.vim'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-sleuth'
    Plug 'sickill/vim-pasta'
    Plug 'airblade/vim-gitgutter'
    
    " Return to last edit position when opening files (You want this!)
    "
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

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
    set clipboard+=unnamedplus " Yank to clipboard
    set mouse=nv

    " Appearance
    "
    set number
    " set relativenumber
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
    set cursorline

    " Theme {{{
      Plug 'KeitaNakamura/neodark.vim'
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

    function! FoldRegion(expr)
      let lnr = search(a:expr, 'wn')
      if lnr != 0
        exec 'normal!'.lnr.'Gza``'
      endif
    endfunction

    " Comments
    let g:NERDDefaultAlign = 'start'
    let g:NERDSpaceDelims = 1
    let g:NERDCreateDefaultMappings = 0
    
    " Lualine {{{
      Plug 'hoob3rt/lualine.nvim'
    " }}}
  " }}}
  
  " KeyMap {{{
    
      let mapleader = ';'

      " Hack for wrapped lines
      nnoremap <silent> j gj
      nnoremap <silent> k gk

      " Save a keystroke
      nnoremap <silent> <C-s> :w<CR>

      " ;nu and ;rnu to toggle numbering
      nnoremap <silent> <leader>nu :set nu!<CR>
      nnoremap <silent> <leader>rnu :set rnu!<CR>

      nnoremap <silent> <Leader><Leader> :set hls!<CR>

      nnoremap <silent> <C-j> 3<C-e>
      nnoremap <silent> <C-k> 3<C-y> 
      nnoremap <silent> <C-Down> <C-e>
      nnoremap <silent> <C-Up> <C-y>

      " Use Ctrl + / to comment
      nnoremap <silent> <C-_> :call NERDComment(0, "toggle")<CR>
      vnoremap <silent> <C-_> :call NERDComment(0, "toggle")<CR>
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

    function! StartUp()
        if 0 == argc()
            NERDTree
        end
    endfunction
    autocmd VimEnter * call StartUp()
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

    nnoremap <silent> <leader>p :CtrlP getcwd()<CR>
    nnoremap <silent> <leader><tab> :CtrlPBuffer<CR>

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn|vendor|node_modules)$',
      \ 'file': '\v\.(exe|so|dll|class|jar)$',
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
    " i3config {{{
    Plug 'mboughaba/i3config.vim'
    aug i3config_ft_detection
      au!
      au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
    aug end
    " }}} 
    
    
    " Go {{{
      Plug 'fatih/vim-go'

      function AltCrAction()
        let syntaxToken = synIDattr(synID(line("."), col("."), 1), "name")
        if syntaxToken == "goTypeConstructor"
          :GoFillStruct
        elseif syntaxToken == "goTypeName"
          :GoImpl
        endif
      endfunction

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

      autocmd FileType go nnoremap <silent> <A-cr> :call AltCrAction()<CR>
      autocmd FileType go nnoremap <silent> <A-R> :GoRename<CR>
      autocmd FileType go map <silent> <C-q> :GoDoc<CR>
      autocmd FileType go setlocal tabstop=4
      autocmd FileType go setlocal shiftwidth=4
      autocmd FileType go map <silent> <C-A-l> :GoFmt<CR>:GoImports<CR>

      " Debugging 
      let g:go_debug_windows = {
        \ 'vars': 'rightbelow 40vnew',
        \ 'out': 'bot 5new',
        \}
      let g:go_debug_preserve_layout = 1
      autocmd FileType go :call FoldRegion('^import (\_.*\n)')
    " }}}
    
    " rust {{{
      Plug 'cespare/vim-toml'
      Plug 'rust-lang/rust.vim'

      let g:cargo_shell_command_runner = '!'
      let g:rustfmt_autosave = 1

      autocmd FileType rust map <silent> <leader>cb :Cargo build<CR>
      autocmd FileType rust map <silent> <C-A-l> :RustFmt<CR>
      autocmd FileType rust nmap <silent> <A-cr> :CocAction<CR>
    " }}}"
    
    " DAP{{{
      Plug 'mfussenegger/nvim-dap'
      Plug 'rcarriga/nvim-dap-ui'
      Plug 'theHamsta/nvim-dap-virtual-text'

      nnoremap <silent> <leader>` :lua require'dapui'.toggle()<CR>
      nnoremap <silent> <F9> :lua require'dap'.continue()<CR>
      nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>
      nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
      nnoremap <silent> <F6> :lua require'dap'.step_out()<CR>
      nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
      nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
      nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
      nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
      nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
    "}}}"
    
    " vimrc {{{
      let g:NERDDefaultAlign = 'none'
    " }}}
    
    " Java {{{
      autocmd FileType java nmap <silent> <A-cr> :CocAction<CR>
    " }}}"

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

      autocmd FileType typescript nmap <silent> <A-cr> :CocAction<CR>
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

  "Buffer Line {{{
    Plug 'akinsho/nvim-bufferline.lua'

    map <silent> <A-Right> :BufferLineCycleNext<CR>
    map <silent> <A-Left> :BufferLineCyclePrev<CR>
    nnoremap <silent> <Tab><Tab> :b#<CR>
  "}}}"
call plug#end()


" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" These calls must be after plug#end() to ensure that theme loads

set background=dark
" let g:space_vim_dark_background = 234
set termguicolors
let g:neodark#background = '#202020'
let g:neodark#solid_vsplit = 1
colorscheme neodark
" hi LineNr ctermbg=NONE guibg=NONE
" hi Comment guifg=#5C6370 ctermfg=59

lua <<END
require'lualine'.setup {
  tabline = {
    lualine_z = {'filename'},
  }
}

local dap = require'dap'
dap.adapters.go = {
  type = "server",
  host = "127.0.0.1",
  port = 38697,
}

if vim.fn.filereadable('./debugopts.lua') ~= 0 then
  print('loading debugopts')
  require'debugopts'.setup(dap.configurations)
end

vim.g.dap_virtual_text = true
require'dapui'.setup()

require'bufferline'.setup{
  options = {
    numbers = "buffer_id",
    number_style = "superscript",
    close_command = "bdelete %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = "bdelete %d",
    close_icon = '[x]',
    modified_icon = '[-]',
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, evel, diagnostics_dict, context)
      return "("..count..")"
    end,
    offsets = {
      {
          filetype = "nerdtree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left"
      }
    }
  }
}
END
