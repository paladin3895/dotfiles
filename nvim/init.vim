if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "javascript,php,python"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'yegappan/greplace'
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
" Plug 'craigemery/vim-autotag'
" Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'avelino/vim-bootstrap-updater'
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc'
Plug 'lervag/vimtex'
Plug 'rhysd/vim-grammarous'
Plug 'eugen0329/vim-esearch'
Plug 'yuratomo/w3m.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/vimwiki'
" Plug 'gerw/vim-latex-suite'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'terryma/vim-multiple-cursors'
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'vim-scripts/dbext.vim'
Plug 'mechatroner/rainbow_csv'
Plug 'tpope/vim-abolish'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neoyank.vim'
Plug 'justinhoward/fzf-neoyank'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ap/vim-css-color'

" Plug 'SirVer/ultisnips'
" Plug 'easymotion/vim-easymotion'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'thinca/vim-quickrun'
Plug 'dhruvasagar/vim-table-mode'
Plug 'jpalardy/vim-slime'
Plug 'godlygeek/tabular'

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'diepm/vim-rest-console'

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  "" Snippets
  " Plug 'SirVer/ultisnips'
endif

" enable gtags module
" let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
" let g:gutentags_project_root = []

" generate datebases in my cache directory, prevent gtags files polluting my project
" let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
" let g:gutentags_plus_switch = 1

" set statusline+=%{gutentags#statusline()}

" let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnippets'
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultisnippets']

" if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" endif
" let g:deoplete#enable_at_startup = 0

"" Color
Plug 'tomasr/molokai'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'
Plug 'flowtype/vim-flow'


" php
"" PHP Bundle
Plug 'arnaud-lb/vim-php-namespace'


" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


"*****************************************************************************
"" User bundles
"*****************************************************************************
" Plug 'ctrlpvim/ctrlp.vim'
"
" Plug 'justinmk/vim-sneak'
" let g:sneak#label = 1

" Plug 'vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on

" vim-table
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='-'

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
let g:esearch = {
  \ 'adapter':          'ag',
  \ 'backend':          'nvim',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'hlsearch', 'last'],
  \ 'default_mappings': 1,
  \}

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Live substitute
if has('nvim')
    set inccommand=nosplit
endif

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"pipe
let g:pipe_no_mappings = 1

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.wiki'}]

" v-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_haskell_ghci_add_let = 0

" vim-rest-console
let g:vrc_output_buffer_name = '__VRC_OURPUT__.json'
let g:vrc_split_request_body = 1
let g:vrc_curl_opts = {
  \ '--connect-timeout' : 10,
  \ '--max-time': 60,
  \ '--ipv4': '',
  \ '-s': '',
  \ '-k': '',
\}

augroup vrc-set-modifiable
  autocmd!
  autocmd BufEnter __VRC_OURPUT__.json :set modifiable | %!python -m json.tool
augroup END

" Use your key
" noremap <leader><bar>x :Pipe
" noremap <leader><bar>c :PipeToggleWindow<CR>
"*****************************************************************************
"" Visual Settings
"*****************************************************************************
"
"
syntax on
set ruler
set number

let no_buffers_menu=1
let g:solarized_termcolors=256
if !exists('g:not_finish_vimplug')
  set background=dark
  colorscheme solarized
endif

set mouse=a
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 8

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

endif



"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" eslint
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_args=['--cache']
" let g:syntastic_javascript_eslint_exe = 'npm run lint --'
" let g:flow#enable = 0

" cpp
" let g:syntastic_cpp_compiler_options = ' -std=c++11'

nnoremap <leader>w3t :W3mTab<Space>
nnoremap <leader>w3y :W3mTab <C-r>0

" ycm
let g:ycm_auto_trigger = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p', '<Up>']
" let g:ycm_key_list_stop_completion= ['<c-y>']
" let g:ycm_use_ultisnips_completer = 1

" UltiSnips
" let g:UltiSnipsExpandTrigger = "<tab>"
" inoremap <c-x><c-k> <c-x><c-k>
" inoremap <Tab> <c-r>=UltiSnips#ExpandSnippet()<cr>
" let g:UltiSnipsExpandTrigger = "<c-tab>"
" let g:UltiSnipsListSnippets = "<c-s-tab>"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsEditSplit="vertical"

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" terminal emulation
set splitbelow
set splitright
if g:vim_bootstrap_editor == 'nvim'
  nnoremap <silent> <leader>sh :terminal<CR>
else
  nnoremap <silent> <leader>sh :VimShellCreate<CR>
endif

" Rainbow_csv
let g:rbql_backend_language = 'js'

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"" use cscope
" if has('cscope')
"   set cscopetag cscopeverbose

"   if has('quickfix')
"     set cscopequickfix=s-,c-,d-,i-,t-,e-
"   endif

"   " C symbol
"   nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"   " definition
"   nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"   " functions that called by this function
"   nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"   " funtions that calling this function
"   nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"   " test string
"   nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"   " egrep pattern
"   nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"   " file
"   nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"   " files #including this file
"   nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

"   " cnoreabbrev csa cs add
"   " cnoreabbrev csf cs find
"   " cnoreabbrev csk cs kill
"   " cnoreabbrev csr cs reset
"   " cnoreabbrev css cs show
"   " cnoreabbre

"   " command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
" endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" update cscope
" augroup update-cscope
"   autocmd!
"   autocmd BufEnter * :syntax sync maxlines=1000
" augroup END

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

augroup vimrc-haskell
  au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
  " au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
  " au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
augroup END

"" update ctags
" augroup vimrc-update-ctags
"   autocmd BufWritePost *.js,*.php,*.vue silent! !ctags -R &
" augroup END
"

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>_ :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gp :Gpush<CR>
noremap <Leader>gl :Gpull<CR>
noremap <Leader>gst :Gstatus<CR>
noremap <Leader>gbl :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" gitgutter
noremap <Leader>gh :GitGutterPreviewHunk<CR>
noremap <Leader>g> :GitGutterNextHunk<CR>
noremap <Leader>g< :GitGutterPrevHunk<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
" noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>y :FZFNeoyank<cr>

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" copy and paste clipboard registry to vim default reg
" noremap <leader>y "+y<CR>
" noremap <leader>p "+gP<CR>
noremap <leader>% :let @"=@%<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>c :bd!<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <leader>j <C-w>j<Esc>
noremap <leader>k <C-w>k<Esc>
noremap <leader>l <C-w>l<Esc>
noremap <leader>h <C-w>h<Esc>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"" Quickly change filetype
nnoremap <leader>* :setfiletype 

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" vue
autocmd FileType vue syntax sync fromstart
augroup vimrc-vue
  autocmd!
  autocmd FileType vue set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
augroup END

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
augroup END

" vim-typescript
augroup vimrc-typescript
  autocmd!
  autocmd FileType typescript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END

" php
augroup vimrc-php
  autocmd!
  autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
augroup END


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
" let g:jedi#popup_on_dot = 0
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = "<leader>d"
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#show_call_signatures = "0"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#smart_auto_mappings = 0

" syntastic
let g:syntastic_python_checkers=['python', 'flake8']

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1

" latex
let g:tex_flavor='latex'

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
  source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"*****************************************************************************
"" Experiment
"*****************************************************************************
set timeoutlen=1000
" Make space more useful
nnoremap <Leader>R :source $MYVIMRC<CR>
nnoremap <Space> li<CR><Esc>O

nnoremap <A-k> :resize +10<CR>
nnoremap <A-j> :resize -10<CR>
nnoremap <A-h> :vertical resize +10<CR>
nnoremap <A-l> :vertical resize -10<CR>

" Surround in visual mode
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Terminal mapping
tnoremap <Esc> <C-\><C-n>

" Utilities
vnoremap <leader># :call ExecuteScript()<CR>
vnoremap <leader>bc "ey:call CalcBC()<CR>

nnoremap <leader><Tab> :call SetTabWidth()<CR>

"*****************************************************************************
"" Database
"*****************************************************************************
source ~/.config/nvim/db.vim

"*****************************************************************************
"" Coc.vim
"*****************************************************************************
source ~/.config/nvim/coc.vim

" let g:dbext_default_MYSQL_extra = '--batch --raw'

nnoremap <leader>;? :DBSetOption profile=
nnoremap <leader>;x :DBExecSQLUnderCursor<CR>
vnoremap <leader>;x :DBExecVisualSQL<CR>
nnoremap <leader>;c :DBResultsClose<CR>
nnoremap <leader>;c :SyntasticToggleMode<CR>
nnoremap <leader>;o :DBResultsOpen<CR>
nnoremap <leader>;t :DBDescribeTable<CR>
nnoremap <leader>;d :DBListTable<CR>
nnoremap <leader>;s :DBSelectFromTableWithWhere<CR>
nnoremap <leader>;* :DBListColumn<CR>

nnoremap <leader>;; :Semicolon<CR>
nnoremap <leader>;> :SemicolonRun<CR>

vnoremap <leader>;u :call GenerateUpdate()<CR>
vnoremap <leader>;i :call GenerateCreate()<CR>
vnoremap <leader>;v :call ViewTable()<CR>
vnoremap <leader>;_ :call Lodash()<CR>
vnoremap <leader>;; <ESC>:Semicolon<CR>
vnoremap <leader>;> <ESC>:SemicolonRun<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction

function! ViewTable() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| _.chain -i csv -o table | bcat')
endfunction

function! GenerateUpdate() range
  let expression = 'echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| _.chain -i csv -o update'
  call setreg('0', system(expression))
endfunction

function! GenerateCreate() range
  let expression = 'echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| _.chain -i csv -o insert'
  call setreg('0', system(expression))
endfunction

function! GenerateUpsert() range
  let expression = 'echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| _.chain -i csv -o upsert'
  call setreg('0', system(expression))
endfunction

function! ExecuteScript() range
  call inputsave()
  let scripttype = input('Enter script type: ')
  call inputrestore()

  if strlen(scripttype) > 0
    execute "'<,'>QuickRun ".scripttype
  else
    execute "'<,'>QuickRun zsh"
  endif
endfunction

function! Lodash() range

  let data = shellescape(join(getline(a:firstline, a:lastline), "\n"))
  call inputsave()
  let expression = input('Enter chain command: ')
  call inputrestore()

  let result = ''
  if expression
    result = system('echo '.input."| _.chain -i line '".expression."'")
  endif

  echom result
endfunction

function! CalcBC()
  let has_equal = 0
  " remove newlines and trailing spaces
  let @e = substitute (@e, "\n", "", "g")
  let @e = substitute (@e, '\s*$', "", "g")
  " if we end with an equal, strip, and remember for output
  if @e =~ "=$"
    let @e = substitute (@e, '=$', "", "")
    let has_equal = 1
  endif
  " sub common func names for bc equivalent
  let @e = substitute (@e, '\csin\s*(', "s (", "")
  let @e = substitute (@e, '\ccos\s*(', "c (", "")
  let @e = substitute (@e, '\catan\s*(', "a (", "")
  let @e = substitute (@e, "\cln\s*(", "l (", "")
  " escape chars for shell
  let @e = escape (@e, '*()')
  " run bc, strip newline
  let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
  " append answer or echo
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echo "answer = " . answer
  endif
endfunction

function! SetTabWidth()
  call inputsave()
  let tabWidth = input('Enter tab width: ')
  call inputrestore()

  execute("set tabstop=" . tabWidth)
  execute("set softtabstop=" . tabWidth)
  execute("set shiftwidth=" . tabWidth)
  execute("set expandtab")
  execute("set smarttab")
endfunction
