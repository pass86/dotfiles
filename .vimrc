"-------------------------------------------------------------------------------
" 基础
"-------------------------------------------------------------------------------

" 不自动换行
set nowrap

" 显示行号
set number

" 显示命令
set showcmd

" 忽略大小写
set ignorecase

" 高亮当前行, 会导致画面重绘变慢
set cursorline

" 使用老的正则表达式引擎, 能缓解画面重绘变慢
set regexpengine=1

" 有输入才重绘, 能缓解画面重绘变慢
set lazyredraw

" 显示状态栏
set laststatus=2

" 实时搜索
set incsearch

" 搜索时高亮显示被找到的文本
set hlsearch

" 自动缩进使用的空格数
set shiftwidth=4

" Tab转换为空格的个数
set tabstop=4

" 插入的Tab用tabstop个的空格替换
set expandtab

" 不进行写备份
set nowritebackup

" 临时文件(file.swp)存放目录, 空表示不生成临时文件
set directory=~/dotfiles/vim/tmp

" 备份文件(file~)存放目录, 空表示不生成备份文件
set backupdir=~/dotfiles/vim/backup

" 重做文件(.file.un~)存放目录, 空表示不生成重做文件
set undodir=~/dotfiles/vim/undo

" 允许在有未保存的修改时切换缓冲区
set hidden

" 自动设当前编辑的文件所在目录为当前工作路径
set autochdir

" cscope结果输出到quickfix窗口
set cscopequickfix=s-,c-,d-,i-,t-,e-

" 默认编码
set encoding=utf-8

" 文件编码识别顺序
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 不显示preview窗口, 因为会导致界面下拉而抖动
set completeopt=longest,menu 

" 自动加载被修改的文件
set autoread

" 设置状态栏, 额外显示文件全路径, 文件编码格式, 行尾方式, 文件类型
set statusline=%<%F\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [%{&ff}]\ %y\ %k\ %-14.(%l,%c%V%)\ %P

" 解决插入模式Backspace无效的问题
set backspace=indent,eol,start

" 行尾方式识别顺序
set fileformats=unix,dos

" 设置字典
"set dictionary+=~/dotfiles/vim/dictionary/2+2gfreq.txt

" 从当前文件所在目录开始向上搜索tags, ;代表了向上搜索
set tags=tags;

" 颜色数
set t_Co=256

" 使用系统剪切板, tmux on macos need install https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
set clipboard=unnamed

" 运行时文件搜索目录
set runtimepath=~/dotfiles/vim,$VIMRUNTIME

"-------------------------------------------------------------------------------
" 杂项
"-------------------------------------------------------------------------------

" 打开语法高亮
syntax on

" 快速加载vimrc 
map <silent> <leader>ss :source $MYVIMRC<cr>

" 快速编辑vimrc 
map <silent> <leader>ee :e $MYVIMRC<cr>

" vimrc修改后马上加载
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" 打开返回上次修改的位置
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

" python脚本使用unix行尾方式, 为了支持#!/usr/bin/env python
augroup filetype
    au! BufRead,BufNewFile *.py set fileformat=unix
augroup end

" 启用文件类型插件和缩进
filetype plugin indent on

" 平台特性
if has("win32")
    source $VIMRUNTIME/mswin.vim
    source $VIMRUNTIME/vimrc_example.vim

    " 最大化窗口
    au GUIEnter * simalt ~x 

    " 消息语言
    let $LANG="en"

    " 菜单语言
    set langmenu=en

    " 解决控制台中文乱码
    set termencoding=chinese

    " 搜索路径
    set path+=$VC_INCLUDE_DIR
    set path+=$SDK_INCLUDE_DIR
    set path+=$BOOST_ROOT
    set path+=$PROTOBUF_ROOT\\src

    if has("gui_running")
        " 不显示菜单栏和工具栏
        set guioptions=""

        " 字体
        set guifont=Source\ Code\ Pro,Consolas
    endif
else
    set path+=/usr/local/include
endif

"-------------------------------------------------------------------------------
" 工具函数
"-------------------------------------------------------------------------------

" 关闭其他所有缓冲区
function! G_close_all_buffers_but_current()
    let curr = bufnr("%")
    let last = bufnr("$")
    if curr > 1 | silent! execute "1," . (curr - 1) . "bd" | endif
    if curr < last | silent! execute (curr + 1) . "," . last . "bd" | endif
endfunction
nnoremap <leader>co :call G_close_all_buffers_but_current()<cr>

"-------------------------------------------------------------------------------
" 插件
"-------------------------------------------------------------------------------

" a
set runtimepath+=~/dotfiles/vim/bundle/a.vim

" ack
set runtimepath+=~/dotfiles/vim/bundle/ack.vim
let g:ackpreview = 1
let g:ackhighlight = 1
let g:ack_autoclose = 1
if executable("ag")
    let g:ackprg = "ag --vimgrep --smart-case"
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" mru
set runtimepath+=~/dotfiles/vim/bundle/mru
if has("win32")
    let MRU_Exclude_Files = "*.svn\\.*|^C:\\Windows\\Temp\\.*"
else
    let MRU_Exclude_Files = "*.svn/.*|^/tmp/.*\|^/var/tmp/.*\|^/var/folders/.*"
endif

" supertab
set runtimepath+=~/dotfiles/vim/bundle/supertab
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" ctrlp
set runtimepath+=~/dotfiles/vim/bundle/ctrlp.vim
let g:ctrlp_max_files = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
 \ "dir":  "\v[\/]\.(git|hg|svn)$|Temp|Library",
 \ "file": "\v\.(exe|so|dll|meta|png|jpg|prefab|mat|unity|mp3|mp4|wav|anim|fbx|asset|csproj|bytes|db)$",
 \ "link": "SOME_BAD_SYMBOLIC_LINKS",
 \ }

" ultisnips
set runtimepath+=~/dotfiles/vim/bundle/ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsSnippetDirectories=["snippet"]

" auto-pairs
set runtimepath+=~/dotfiles/vim/bundle/auto-pairs

" nerdtree
set runtimepath+=~/dotfiles/vim/bundle/nerdtree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
map <c-n> :NERDTreeToggle<cr>
nnoremap <leader>e :buffer NERD_tree_1<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter
set runtimepath+=~/dotfiles/vim/bundle/nerdcommenter

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

" vim-startify
set runtimepath+=~/dotfiles/vim/bundle/vim-startify

" YouCompleteMe
set runtimepath+=~/dotfiles/vim/bundle/YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:syntastic_enable_highlighting = 0
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf_macos.py"
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/8.0.0/include
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
    endif
elseif has("win32")
    let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf_windows.py"
endif
nnoremap <leader>jd :YcmCompleter GoTo<cr>
