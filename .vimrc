" Only part of long lines will be displayed
set nowrap

" The case of normal letters is ignored
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase

" While typing a search command, show where the pattern, as it was typed so far, matches
set incsearch

" When there is a previous search pattern, highlight all its matches
set hlsearch

" No backup made
set nobackup
set nowritebackup

" No swapfile for the buffer
set noswapfile

" No undofile for the buffer
set noundofile

" Hide buffers instead of closing them
set hidden

" Sets the character encoding used inside Vim
set encoding=utf-8

" A list of character encodings considered when starting to edit an existing file
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Gives the end-of-line (<EOL>) formats that will be tried when starting to edit a new buffer and when reading a file into an existing buffer
set fileformats=unix,dos

" This gives the <EOL> of the current buffer, which is used for reading/writing the buffer from/to a file
set fileformat=unix

" A comma separated list of options for Insert mode completion
set completeopt=longest,menu

" Change the current working directory whenever you open a file, switch buffers, delete a buffer or open/close a window
set autochdir

" When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again
set autoread

" Allow backspace
set backspace=indent,eol,start

" Search tags upwards
set tags=tags;

" Use system clipboard
set clipboard=unnamed,unnamedplus

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set expandtab

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Number of spaces that a <Tab> in the file counts for
set tabstop=4

" Avoid the hit-enter prompts caused by file messages
set shortmess=AF

" Specifies whether to use quickfix window to show cscope results
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

" Always a status line
set laststatus=2

" Determines the content of the status line. Full path, File encoding, Line ending, File type, Line, Column, Percentage
set statusline=%<%F\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [%{&ff}]\ %y\ %k\ %-14.(%l,%c%V%)\ %P

" Smooth scroll settings
set lazyredraw " The screen will not be redrawn while executing macros, registers and other commands that have not been typed
set regexpengine=1 " Selects the default regexp engine
set noshowcmd " Show (partial) command in the last line of the screen
set ttyfast " Indicates a fast terminal connection
set synmaxcol=200 " Maximum column in which to search for syntax items

" Set terminal's number of colors
set t_Co=256

" Enable file type detection
filetype plugin indent on

" To switch syntax highlighting on according to the current value of the 'filetype' option
syntax on

" A list of directories which will be searched when using the gf and other commands
if has("win32")
  set path=.
elseif has("unix")
  set path=.,/usr/local/include,/usr/include
endif

" No GUI feature
set guioptions=

" A list of fonts which will be used for the GUI version of Vim
if has("win32")
  set guifont=Hack:h8,Source\ Han\ Sans\ SC:h8,Consolas:h8
elseif has("unix")
  set guifont=Hack:h12,Source\ Han\ Sans\ SC:h12,Consolas:h12
endif

if has("win32")
  " Maximize window
  autocmd GUIEnter * simalt ~x
endif

" Disable beep and flash
autocmd GUIEnter * set visualbell t_vb=

" Vim's indent
autocmd FileType vim setlocal shiftwidth=2 tabstop=2

" JavaScript's indent
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Return to last edit position after read
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Edit $MYVIMRC
map <silent> <Leader>ee :e $MYVIMRC<CR>

" Load $MYVIMRC
map <silent> <Leader>ss :source $MYVIMRC<CR>

" Use enter jump to tag except quickfix
nmap <expr> <CR> &buftype ==# "quickfix" ? "<CR>" : "<C-]>"

" Quick close other buffers
function! CloseOtherBuffers()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1 | silent! execute "1," . (curr - 1) . "bd" | endif
  if curr < last | silent! execute (curr + 1) . "," . last . "bd" | endif
endfunction
nnoremap <Leader>co :call CloseOtherBuffers()<CR>

" A list of directories which will be searched for runtime files
set runtimepath=~/dotfiles/vim,$VIMRUNTIME

" a.vim
set runtimepath+=~/dotfiles/vim/bundle/a.vim
let g:alternateExtensions_h = "cpp,cxx,cc,c"
let g:alternateExtensions_H = "CPP,CXX,CC,C"
map <C-g> :A<CR>

" ack.vim
set runtimepath+=~/dotfiles/vim/bundle/ack.vim
let g:ackpreview = 1
let g:ackhighlight = 1
let g:ack_autoclose = 1
if executable("ag")
  let g:ackprg = "ag --ignore tags --ignore Makefile --ignore CMakeFiles --ignore CMakeCache.txt -Q"
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" auto-pairs
set runtimepath+=~/dotfiles/vim/bundle/auto-pairs

" mru
set runtimepath+=~/dotfiles/vim/bundle/mru
if has("win32")
  let MRU_Exclude_Files = '.*/.svn/.*\|^C:\\Windows\\Temp\\.*'
elseif has("unix")
  let MRU_Exclude_Files = '.*/.svn/.*\|^/tmp/.*\|^/var/tmp/.*\|^/var/folders/.*'
endif

" ctrlp.vim
set runtimepath+=~/dotfiles/vim/bundle/ctrlp.vim
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
  \ "dir": '\v\.(git|hg|svn)$|build$|bin$|lib$|CMakeFiles$|Debug$|Release$|xcuserdata$|Temp$|Library$|Resources$',
  \ "file": '\v\.(exe|so|dll|obj|a|o|d|meta|png|jpg|psd|prefab|mat|unity|mp3|mp4|wav|ogg|anim|fbx|asset|csproj|bytes|db|cmake|sln|filters|vcxproj|opendb|user)$|tags$|CMakeCache\.txt$',
  \ }
let g:ctrlp_mruf_exclude = MRU_Exclude_Files
let g:ctrlp_root_markers = [ ".ctrlp" ]
map <C-l> :CtrlPMRU<CR>

" vim-gutentags
set runtimepath+=~/dotfiles/vim/bundle/vim-gutentags
let g:gutentags_add_default_project_roots = 0

" nerdtree
set runtimepath+=~/dotfiles/vim/bundle/nerdtree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter
set runtimepath+=~/dotfiles/vim/bundle/nerdcommenter

" open-browser.vim
set runtimepath+=~/dotfiles/vim/bundle/open-browser.vim
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" supertab
set runtimepath+=~/dotfiles/vim/bundle/supertab
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<C-n>"
let g:SuperTabContextDefaultCompletionType = "<C-n>"

" ShaderHighLight
set runtimepath+=~/dotfiles/vim/bundle/ShaderHighLight

" vim-autoread
set runtimepath+=~/dotfiles/vim/bundle/vim-autoread

" vim-bookmarks
function! g:BMWorkDirFileLocation()
  if filereadable(".vim-bookmarks")
    let work_dir = getcwd()
  else
    let up_path = findfile(".vim-bookmarks", ".;")
    if len(up_path) > 0
      let work_dir = substitute(up_path, ".vim-bookmarks", "", "")
    else
      let work_dir = ""
    endif
  endif
  if len(work_dir) > 0
    return work_dir . "/.vim-bookmarks"
  else
    return g:bookmark_auto_save_file
  endif
endfunction
set runtimepath+=~/dotfiles/vim/bundle/vim-bookmarks
let g:bookmark_auto_close = 1
let g:bookmark_disable_ctrlp = 1
let g:bookmark_save_per_working_dir = 1

" vim-reveal-in-finder
set runtimepath+=~/dotfiles/vim/bundle/vim-reveal-in-finder
nnoremap <Leader><CR> :Reveal<CR>

" vim-airline
set runtimepath+=~/dotfiles/vim/bundle/vim-airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnamemod = ":t"

" vim-airline-themes
set runtimepath+=~/dotfiles/vim/bundle/vim-airline-themes
let g:airline_theme = "dark"

" vim-startify
set runtimepath+=~/dotfiles/vim/bundle/vim-startify
let g:startify_skiplist = [MRU_Exclude_Files]
let g:startify_change_to_dir = 0 " Fix autochdir failed in ctrlp

" vim-youdao-translater
set runtimepath+=~/dotfiles/vim/bundle/vim-youdao-translater
vnoremap <silent> <C-t> :<C-u>Ydv<CR>
nnoremap <silent> <C-t> :<C-u>Ydc<CR>
noremap <Leader>yd :<C-u>Yde<CR>

" vimwiki
set runtimepath+=~/dotfiles/vim/bundle/vimwiki
let g:vimwiki_conceallevel = 0
let g:vimwiki_list = [{ "path": "~/wiki/", "index": "README", "syntax": "markdown", "ext": ".md" }]
nmap <Leader>tt <Plug>VimwikiToggleListItem
vmap <Leader>tt <Plug>VimwikiToggleListItem

" dracula-theme
set runtimepath+=~/dotfiles/vim/bundle/vim
let g:dracula_italic = 0
let g:dracula_colorterm = 0
color dracula

" UltiSnips
set runtimepath+=~/dotfiles/vim/bundle/ultisnips

" YouCompleteMe
set runtimepath+=~/dotfiles/vim/bundle/YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_filetype_whitelist = {
  \ "c": 1,
  \ "cpp": 1,
  \ "cs": 1,
  \ "go": 1,
  \ "lua": 1,
  \ "python": 1
  \ }
let g:ycm_filter_diagnostics = {
  \ "cs": {
  \   "level": "warning"
  \   }
  \ }
let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_conf.py"
nnoremap <Leader>jd :YcmCompleter GoTo<CR>
