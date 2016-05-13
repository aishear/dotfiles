set nocompatible " Disable vi-compatibility

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" :PlugInstall
" :PlugUpdate
" :PlugClean
call plug#begin('~/.vim/plugged')

"""""""""""""""""""
" General Plugins "
"""""""""""""""""""
" Surround text with stuff
Plug 'tpope/vim-surround'
" Gblame
Plug 'tpope/vim-fugitive'
" Better directory tree management
Plug 'scrooloose/nerdtree'
" Comment out sections of code
Plug 'scrooloose/nerdcommenter'
" Fuzzy search for files
"Plug 'ctrlpvim/ctrlp.vim'
" Better fuzzy search for files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Jump to letters
Plug 'Lokaltog/vim-easymotion'
" Number the items that are found when searching
Plug 'vim-scripts/IndexedSearch'
" Show changed code before commit
Plug 'airblade/vim-gitgutter'
" Automatically add closing ), ], }, ", and '
"Plug 'jiangmiao/auto-pairs'
" Compute MD5 or SHA1 checksum of entire file or range of lines.
Plug 'vim-scripts/checksum.vim'
" Multiple cursors like Sublime Text
Plug 'terryma/vim-multiple-cursors'
" Hacker news
Plug 'ryanss/vim-hackernews'

""""""""""""
" Cosmetic "
""""""""""""
" Solarized color scheme
Plug 'altercation/vim-colors-solarized'
" Paper color theme
Plug 'NLKNguyen/papercolor-theme'
" Rainbow (, [, and {
Plug 'luochen1990/rainbow'
" Light weight interface improvement
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"""""""""""""""
" PHP Plugins "
"""""""""""""""
" Better php autocomplete
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
" Better PHP indenting
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" Better PHP syntax highlighting
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
" PHP error checking
Plug 'joonty/vim-phpqa', { 'for': 'php' }

""""""""""""""""""""""
" Javascript Plugins "
""""""""""""""""""""""
" Better syntax
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Better coloring and syntax
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

""""""""""""""""
" Rust Plugins "
""""""""""""""""
" Syntax and autoformat
Plug 'rust-lang/rust.vim'

"""""""""""""""""""""""""""""""""""
" Plugins that require modern vim "
"""""""""""""""""""""""""""""""""""
if has("python") && v:version >= 704
	" Autocomplete and c++ error checking
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer'  }
	" Autogenerate YCM config
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

	" Snippets
	Plug 'SirVer/ultisnips'

	" PHP debugger
	Plug 'joonty/vdebug', { 'for': 'php' }
endif

" Add plugins to &runtimepath
filetype plugin indent on
call plug#end()

""""""""""""""""""""
" Display Settings "
""""""""""""""""""""
"let g:solarized_termcolors=256
map <F6> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
set background=light
colorscheme PaperColor
" Set indentation settings
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
" Use spaces for python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
" Use spaces for rust
autocmd Filetype rust setlocal expandtab tabstop=4 shiftwidth=4

"""""""""""""""""""
" Editor Settings "
"""""""""""""""""""
" Switch buffers without having to save them first
set hidden

" Open zip archives that don't use .zip extension
au BufReadCmd *.jar,*.spk call zip#Browse(expand("<amatch>"))

" Highlighting in search
set incsearch
set hlsearch
" better search
set ignorecase
set smartcase

" Normal backspace behavior
set backspace=indent,eol,start

" Set persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Show whitespace
set nolist
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•,eol:¬
" F7: toggle display of tabs/spaces/etc
nmap <F7> :set list!<return>
highlight ExtraWhitespace ctermbg=lightred guibg=lightred
" highlight trailing spaces if you're not currently typing and highlight spaces before tabs
autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/ containedin=ALL

" Toggle spell checking
nmap <F1> :set spell!<return>

" Relative line numbers on the side
"set relativenumber

" Always highlight the current line
set cursorline

" Cursor crosshair with leader c
nnoremap <Leader>c :set cursorline cursorcolumn!<CR>

" set the leader key
map <SPACE> <leader>
" show when leader has been hit
set showcmd

" move left and right through the open buffers
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>"

"move up and down through word wrapped lines
nnoremap j gj
nnoremap k gk

"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""

"""""""""""""""
" Easy Motion "
"""""""""""""""
map <Leader> <Plug>(easymotion-prefix)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

"""""""""""
" Airline "
"""""""""""
" show airline all the time
set laststatus=2
"  populate the g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#branch#enabled = 1
" Enable the list of buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Hide > and < seperators
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Don't show whitespace errors
let g:airline#extensions#whitespace#enabled = 0

" Number buffers and switch to them with leader+num
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"""""""""""""""""
" YouCompleteMe "
"""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
" set the white list of ycm conf files
let g:ycm_extra_conf_globlist = ['/SevOneNMS/*']
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""""""""""""
" AutoPairs "
"""""""""""""
" Don't prevent closing brace from being inserted if one already exists
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

"""""""
" FZF "
"""""""
nmap <leader>p :FZF<cr>

"""""""""""""
" Ultisnips "
"""""""""""""
" set ultisnips to use a key that doesn't conflict with YCM
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""
" GitGutter "
"""""""""""""
" disable GitGutter on startup
let g:gitgutter_enabled = 0
" F8: toggle git gutter
nmap <F8> :GitGutterToggle<return>
" unmap git gutter keys so that <leader>h works faster
autocmd VimEnter * unmap <leader>hp
autocmd VimEnter * unmap <leader>hr
autocmd VimEnter * unmap <leader>hs


"""""""""""
" Rainbow "
"""""""""""
" Parentheses colours using Solarized
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle"

let g:rainbow_conf = {
\   'guifgs'     : ['#FE2712', '#66B032', '#0392CE', '#FD5308', '#0247FE', '#FB9902', '#8601AF', '#FEFE33', '#A7194B', '#D0EA2B'],
\   'ctermfgs'   : ['0', '1', '2', '3', '6', '9', '10'],
\   'separately' : {
\       '*'   : {
\       },
\       'php'  : {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold', 'start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop'],
\       },
\       'css'  : 0
\   }
\}

""""""""""
" Vdebug "
""""""""""
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 300,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : '',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

"""""""""
" PHPQA "
"""""""""
" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0
" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 0

" PHP syntax highlighting
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

""""""""""""
" Rust.vim "
""""""""""""
" Enable autoformat
"let g:rustfmt_autosave = 1
