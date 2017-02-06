" towry's nvimrc
" https://github.com/towry/dotfiles


" Load plugins
function! NVimrcLoadPlugins()
  if !isdirectory(g:nvim_plug_dir)
    call mkdir(g:nvim_plug_dir, 'p')
  endif
  if !isdirectory(g:nvim_plug_dir.'/autoload')
    execute '!git clone --depth=1 git://github.com/junegunn/vim-plug '
        \ shellescape(g:nvim_plug_dir.'/autoload', 1)
  endif

  call plug#begin()

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'morhetz/gruvbox'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  " Plug 'mxw/vim-jsx', { 'for': 'jsx' }

  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  Plug 'airblade/vim-gitgutter'

  " list, select and switch between buffers
  Plug 'jeetsukumaran/vim-buffergator'
  " Plug 'sandeepcr529/Buffet.vim'
  Plug 'ap/vim-buftabline'
  let g:buftabline_numbers = 1

  " Plug 'vim-scripts/bufkill.vim'
  Plug 'qpkorr/vim-bufkill' " allows you to kill buffer but keep split layout.
  Plug 'ervandew/supertab' " allows you to use <Tab> for all your insert completion needs
  Plug 'mileszs/ack.vim'
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  " Plug 'tpope/vim-vinegar'
  Plug 'jeetsukumaran/vim-filebeagle'
  " Plug 'vim-scripts/SearchComplete'
  Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
  " Plug 'wincent/loupe' " enhances vim's search-commands in four ways.
  Plug 'milkypostman/vim-togglelist'
  Plug 'bronson/vim-trailing-whitespace'

  " === NERDTree
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  let g:NERDTreeIgnore = ['\.pyc$']

  " === CtrlP
  Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_map = ';p'
  let g:ctrl_cmd = ';p'
  if !g:is_windows
    set wildignore+=target/debug/*,tmp/*,*.so,*.swp,*.zip " MacOSX/Linux
  else
    set wildignore+=\\tmp\\*,*.swp,*.zip,*.exe " Windows
  endif
  " let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)|node_modules/|git_home/|bower_components/|vendor/|build/|dist/|dest/|temp/|target/debug/|tmp/|docs/',
    \ 'file': '\v\.(exe|so|dll|png|gif|jpeg|jpg|bmp|pyc)$',
    \ 'link': '',
    \ }

  " === Neomake
  Plug 'benekastah/neomake'
  let g:neomake_verbose = 1
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_python_enabled_makers = ['flake8']
  let g:neomake_rust_enabled_makers = []

  " load local eslint in the project root
  " let s:eslint_path = system('which eslint')
  " let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  let g:neomake_html_enabled_makers = []

  " === Vim-fugitive
  " nnoremap <leader>gs :Gstatus<cr>
  " nnoremap <leader>gd :Gdiff<cr>
  " nnoremap <leader>gb :Gblame<cr>
  " nnoremap <leader>gw :Gwrite
  " nnoremap <leader>gr :Gread
  " nnoremap <leader>dp :diffput<cr>:diffupdate<cr>
  " vnoremap <leader>dp :diffput<cr>:diffupdate<cr>
  " nnoremap <leader>dg :diffget<cr>:diffupdate<cr>
  " vnoremap <leader>dg :diffget<cr>:diffupdate<cr>
  " Plug 'tpope/vim-fugitive'

  call plug#end()
endfunction

function! NVimrcAutoSettings()
  augroup GroupAll
    au!
    au BufWinEnter quickfix nnoremap <silent> <buffer>
          \ q :cclose<cr>:lclose<cr>

    " ======================
    " HTML
    au FileType html
      \   setl foldmethod=marker
      \ | setl foldenable

    " C/C++
    au FileType c,cpp
      \   nnoremap <buffer> <silent> <leader>ff :call Uncrustify('c')<cr>
      \ | setl commentstring=//%s

    " Python
    au FileType python
      \   setl softtabstop=4
      \ | setl shiftwidth=4
      \ | setl textwidth=80
      \ | set expandtab
    command! DocTest !python -m doctest %

    " Vim
    au FileType vim
     \    setl softtabstop=2
     \  | setl shiftwidth=2
     \  | setl expandtab

    au BufNewFile,BufRead *.es set filetype=javascript

    " ======================
    " terminal
    if has('nvim')
      au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
      au WinEnter term://* startinsert
      " let g:terminal_color_0  = '#2e3436'
      " let g:terminal_color_1  = '#cc0000'
      " let g:terminal_color_2  = '#4e9a06'
      " let g:terminal_color_3  = '#c4a000'
      " let g:terminal_color_4  = '#3465a4'
      " let g:terminal_color_5  = '#75507b'
      " let g:terminal_color_6  = '#0b939b'
      " let g:terminal_color_7  = '#d3d7cf'
      " let g:terminal_color_8  = '#555753'
      " let g:terminal_color_9  = '#ef2929'
      " let g:terminal_color_10 = '#8ae234'
      " let g:terminal_color_11 = '#fce94f'
      " let g:terminal_color_12 = '#729fcf'
      " let g:terminal_color_13 = '#ad7fa8'
      " let g:terminal_color_14 = '#00f5e9'
      " let g:terminal_color_15 = '#eeeeec'
    endif

    " =======================
    " Neomake
    au BufWritePost * Neomake

    " disable auto comment
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  augroup END
endfunction

" NVim mapping
function! NVimrcLoadMappings()
  let g:mapleader = ","

  nmap <script> <silent> <F5> :call ToggleQuickfixList()<CR>
  nnoremap ;n :call g:WorkaroundNERDTreeToggle()<CR>
  inoremap <leader><leader> <esc>
  nnoremap <leader>k :bnext<CR>
  nnoremap <leader>j :bprevious<CR>
  nnoremap ;b :Bufferlist<CR>
  nnoremap ;c :BD<CR>
  nnoremap <F9> :update<CR>:Neomake<CR>
  nnoremap <F3> :update<cr><esc>
  inoremap <F3> <c-o>:update<cr><esc>
  inoremap <F10><F10> <c-o>:update<cr><esc>:q<cr>
  nnoremap <F10><F10> :update<cr>:q<cr>
  nnoremap ;w <C-w>
  " visual search
  vnoremap // y/<C-R>"<CR>

  " move text up/down
  " nnoremap <silent> <c-j> :m .+1<cr>==
  " nnoremap <silent> <c-k> :m .-2<cr>==
  " vnoremap <silent> <c-k> :m '<-2<cr>gv=gv
  " vnoremap <silent> <c-j> :m '>+1<cr>gv=gv

  " help
  inoremap <f1> <esc>:help
  nnoremap <f1> <esc>:help
  vnoremap <f1> <esc>:help

  " clear search highlight with ,c
  nnoremap <silent> <leader>c :noh<cr>

  nnoremap <silent> <leader>q :botright copen 10<cr>
  nnoremap <silent> <leader>l :botright lopen 10<cr>

  " Neovim
  if has('nvim')
    tnoremap <Esc> <C-\><C-n>
  endif

endfunction


" NVim settings
function! NVimrcLoadSettings()
  set backspace=indent,eol,start " backspace over everything in insert mode
  set nobackup " no need for backup files(use undo files instead)
  " set undofile " create '.<FILENAME>.un~' for persiting undo history
  set dir=/tmp,. " swap files storage, first try in the cwd then in /tmp
  " set undodir=. " undo files storage, only allow the same directory
  set history=500 " 500 lines of command-line history
  " set mouse=a " enable mouse
  set noerrorbells visualbell t_vb= " disable annoying terminal sounds
  set encoding=utf-8 " universal text encoding, compatible with ascii
  set noequalalways
  set list
  set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮ " ,eol:¬
  set showbreak=↪\
  set fillchars=diff:⣿,vert:│
  set showcmd " display incomplete commands
  set completeopt=menu,menuone,longest " disable preview scratch window
  set complete=.,w,b,u,t " h: 'complete'
  set pumheight=15 " limit completion menu height
  set number " don't display line numbers on the left
  set relativenumber " shows relative line numbers for easy motions
  set colorcolumn=80

  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
  set noexpandtab " expand tabs into spaces

  set ignorecase " ignore case when searching
  set smartcase " disable 'ignorecase' if search pattern has uppercase characters
  set incsearch " highlight matches while typing search pattern
  set hlsearch " highlight previous search matches
  set showmatch " briefly jump to the matching bracket on insert
  set matchtime=2 " time in decisecons to jump back from matching bracket
  " set textwidth=80 " number of character allowed in a line
  set nowrap " automatically wrap text when 'textwidth' is reached
  set foldmethod=indent " by default, fold using indentation
  set nofoldenable " don't fold by default
  set foldlevel=0 " if fold everything if 'foldenable' is set
  set foldnestmax=10 " maximum fold depth
  set synmaxcol=500 " maximum length to apply syntax highlighting
  set timeout " enable timeout of key codes and mappings(the default)
  set timeoutlen=360 " big timeout for key sequences
  set ttimeoutlen=6 " small timeout for key sequences since these will be normally scripted
  set formatoptions-=ro

  " set noantialias
  set display+=lastline
  set splitright
  set splitbelow
  set shortmess=at
  if has('nvim')
    set laststatus=2
    set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P"
    " set cursorline
  end
  " set cursorcolumn
  " set cmdheight=2

  set hidden " switch buffer without saving?

  set wildmenu
  set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif
  set wildmode=list:full
  set scrolloff=3
  " set autochdir

  if $DISABLE_UNNAMED_CLIP != '1'
    set clipboard+=unnamedplus
  endif
  set backupskip=/tmp/*,/private/tmp/* " make it possible to use vim to edit crontab

  " fileformat
  set fileformat=unix
  if g:is_windows
    set fileformats=dos,unix,mac
  else
    set fileformats=unix,dos,mac
  endif

  if g:is_windows
    set shellslash
  endif

  if !has('nvim')
    set ttyfast
    set ruler
  endif

  if has('gui_macvim')
    set guioptions -=m
    set guioptions -=T
  endif
endfunction

" Theme and colors
function! NVimrcLoadColors()
  set background=dark
  colorscheme gruvbox
  if has('gui_macvim')
    set macligatures
    set guifont=Monaco:h13
    set lines=39 columns=88
    " set linespace=2
  endif
endfunction

function! NVimrcStart()
  let g:vimsyn_embed='0'

  call NVimrcLoadMappings()
  if !exists('g:nvimrc_initialized')
    let g:is_windows = has('win32') || has('win64')
    let g:rc_dir = expand('~/.config/nvim')
    let $RCDIR = g:rc_dir
    let g:plugins_dir = g:rc_dir.'/plugged'
    let g:nvim_plug_dir = g:plugins_dir.'/vim-plug'
    let &runtimepath = g:rc_dir.','.g:nvim_plug_dir.','.$VIMRUNTIME
    if !exists('g:disable_plugins')
      let g:has_python = has('python')
      call NVimrcLoadPlugins()
    else
      " plugin is disabled
      " call plug#begin()
      " call plug#end()
    endif
    let g:nvimrc_initialized = 1
  endif

  call NVimrcLoadSettings()
  call NVimrcLoadColors()
  call NVimrcAutoSettings()
endfunction

" =========== S T A R T ===========
call NVimrcStart()
" =================================


" ========== O T H E R . F U N C T I O N ===========
function! g:WorkaroundNERDTreeToggle()
	try
		NERDTreeToggle
	catch
		silent! NERDTree
	endtry
endfunction
