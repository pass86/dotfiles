"-------------------------------------------------------------------------------
" basic
"-------------------------------------------------------------------------------
set nowrap
set number
set showcmd
set ignorecase
set cursorline
" less draw calls
set regexpengine=1
set lazyredraw
set laststatus=2
set incsearch
set hlsearch
set shiftwidth=4
set tabstop=4
set expandtab
set nowritebackup
set directory=~/dotfiles/vim/swap
set backupdir=~/dotfiles/vim/backup
set undodir=~/dotfiles/vim/undo
set hidden
set autochdir
set cscopequickfix=s-,c-,d-,i-,t-,e-
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set completeopt=longest,menu
set autoread
" full path, file encoding, line ending, file type
set statusline=%<%F\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [%{&ff}]\ %y\ %k\ %-14.(%l,%c%V%)\ %P
" fix insert mode backspace
set backspace=indent,eol,start
set fileformats=unix,dos
" search tags upwards
set tags=tags;
set t_Co=256
" system clipboard, tmux on macos need install https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
set clipboard=unnamed
set runtimepath=~/dotfiles/vim,$VIMRUNTIME
set shortmess=A
map <f7> :make<cr><cr><cr>

"-------------------------------------------------------------------------------
" misc
"-------------------------------------------------------------------------------
syntax on

" fast load edit and apply vimrc
map <silent> <leader>ss :source $MYVIMRC<cr>
map <silent> <leader>ee :e $MYVIMRC<cr>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" return to last edit position when open
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

augroup filetype
    au! BufNewFile * set fileformat=unix
augroup end

filetype plugin indent on

set path=.,,

if has("unix")
    set path+=/usr/local/include
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/8.0.0/include
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
        set path+=/usr/local/mysql/include
        set path+=$CPPJIEBA_ROOT/include
        set path+=$LIMONP_ROOT/include
        hi CursorLine cterm=NONE ctermbg=254 ctermfg=NONE
    elseif s:uname == "CYGWIN_NT-10.0-WOW\n"
        hi CursorLine cterm=NONE ctermbg=240 ctermfg=NONE
    else
        set path+=/usr/include/mysql
        hi CursorLine cterm=NONE ctermbg=254 ctermfg=NONE
    endif
    set path+=/usr/include
elseif has("win32")
    source $VIMRUNTIME/mswin.vim
    source $VIMRUNTIME/vimrc_example.vim

    " maximize window
    au GUIEnter * simalt ~x

    let $LANG="en"

    set langmenu=en

    " fix console ecoding messy
    set termencoding=chinese

    set path+=$VC_INCLUDE_DIR
    set path+=$SDK_INCLUDE_DIR
    set path+=$BOOST_ROOT
    set path+=$PROTOBUF_ROOT\\src
    set path+=$MYSQL_ROOT\\include
    set path+=$OPENSSL_ROOT_DIR\\include
    set path+=$CPPJIEBA_ROOT\\include
    set path+=$LIMONP_ROOT\\include

    if has("gui_running")
        " hide menubar and toolbar
        set guioptions=""
        set guifont=Source\ Code\ Pro,Consolas
    endif
endif

"-------------------------------------------------------------------------------
" utility
"-------------------------------------------------------------------------------

function! G_close_all_buffers_but_current()
    let curr = bufnr("%")
    let last = bufnr("$")
    if curr > 1 | silent! execute "1," . (curr - 1) . "bd" | endif
    if curr < last | silent! execute (curr + 1) . "," . last . "bd" | endif
endfunction
nnoremap <leader>co :call G_close_all_buffers_but_current()<cr>

"-------------------------------------------------------------------------------
" plugin
"-------------------------------------------------------------------------------

" a
set runtimepath+=~/dotfiles/vim/bundle/a.vim
map <c-g> :A<cr>

" ack
set runtimepath+=~/dotfiles/vim/bundle/ack.vim
let g:ackpreview = 1
let g:ackhighlight = 1
let g:ack_autoclose = 1
if executable("ag")
    let g:ackprg = "ag --ignore tags --ignore Makefile --ignore CMakeFiles --ignore CMakeCache.txt"
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" auto-pairs
set runtimepath+=~/dotfiles/vim/bundle/auto-pairs

" ctrlp
set runtimepath+=~/dotfiles/vim/bundle/ctrlp.vim
let g:ctrlp_max_files = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
 \ "dir": '\v[\/]\.(git|hg|svn)$|Temp|Library|build|bin|lib|CMakeFiles|Debug',
 \ "file": '\v\.(exe|so|dll|obj|a|o|meta|png|jpg|prefab|mat|unity|mp3|mp4|wav|anim|fbx|asset|csproj|bytes|db|cmake|sln|filters|vcxproj|opendb|user)$|tags|CMakeCache\.txt',
 \ "link": 'SOME_BAD_SYMBOLIC_LINKS',
 \ }
map <c-l> :CtrlPMRU<cr>

" gundo.vim
set runtimepath+=~/dotfiles/vim/bundle/gundo.vim
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1
nnoremap <leader>u :GundoToggle<cr>

" mru
set runtimepath+=~/dotfiles/vim/bundle/mru
if has("unix")
    let MRU_Exclude_Files = '.*/.svn/.*\|^/tmp/.*\|^/var/tmp/.*\|^/var/folders/.*'
elseif has("win32")
    let MRU_Exclude_Files = '.*/.svn/.*\|^C:\\Windows\\Temp\\.*'
endif

" nerdtree
set runtimepath+=~/dotfiles/vim/bundle/nerdtree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
map <c-n> :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter
set runtimepath+=~/dotfiles/vim/bundle/nerdcommenter

" supertab
set runtimepath+=~/dotfiles/vim/bundle/supertab
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" ShaderHighLight
set runtimepath+=~/dotfiles/vim/bundle/ShaderHighLight

" ultisnips
set runtimepath+=~/dotfiles/vim/bundle/ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsSnippetDirectories=["snippet"]

" vim-bookmarks
function! g:BMWorkDirFileLocation()
    if filereadable(".vim-bookmarks")
        let work_dir = getcwd()
    else
        let hint_path = findfile(".vim-bookmarks", ".;")
        if len(hint_path) > 0
            let work_dir = substitute(hint_path, ".vim-bookmarks", "", "")
        else
            let work_dir = ""
            for hint in [".git", ".svn"]
                if isdirectory(hint)
                    let work_dir = getcwd()
                    break
                else
                    let hint_path = finddir(hint, ".;")
                    if len(hint_path) > 0
                        let work_dir = substitute(hint_path, hint, "", "")
                        break
                    endif
                endif
            endfor
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
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1

" vim-reveal-in-finder
set runtimepath+=~/dotfiles/vim/bundle/vim-reveal-in-finder
nnoremap <leader><cr> :Reveal<cr>

" vim-airline
set runtimepath+=~/dotfiles/vim/bundle/vim-airline

" vim-airline-themes
set runtimepath+=~/dotfiles/vim/bundle/vim-airline-themes
let g:airline_theme='light'

" vim-startify
set runtimepath+=~/dotfiles/vim/bundle/vim-startify
let g:startify_skiplist = [MRU_Exclude_Files]
" fix autochdir failed in ctrlp
let g:startify_change_to_dir = 0

" vim-youdao-translater
set runtimepath+=~/dotfiles/vim/bundle/vim-youdao-translater
vnoremap <silent> <c-t> :<c-u>Ydv<cr>
nnoremap <silent> <c-t> :<c-u>Ydc<cr>
noremap <leader>yd :<c-u>Yde<cr>

" vimwiki
set runtimepath+=~/dotfiles/vim/bundle/vimwiki
let g:vimwiki_conceallevel = 0

" YouCompleteMe
set runtimepath+=~/dotfiles/vim/bundle/YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:syntastic_enable_highlighting = 0
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf_macos.py"
    else
        let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf_linux.py"
    endif
elseif has("win32")
    let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf_windows.py"
endif
nnoremap <leader>jd :YcmCompleter GoTo<cr>
