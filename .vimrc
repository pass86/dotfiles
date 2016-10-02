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
set directory=~/dotfiles/tmp

" 备份文件(file~)存放目录, 空表示不生成备份文件
set backupdir=~/dotfiles/backup

" 重做文件(.file.un~)存放目录, 空表示不生成重做文件
set undodir=~/dotfiles/undo

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
"set dictionary+=~/dotfiles/dictionary/2+2gfreq.txt

" 从当前文件所在目录开始向上搜索tags, ;代表了向上搜索
set tags=tags;

" 颜色数
set t_Co=256

" 使用系统剪切板, tmux on macos need install https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
set clipboard=unnamed

" 运行时文件搜索目录
set runtimepath=~/dotfiles,$VIMRUNTIME

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

" protobuf语法高亮
augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" python脚本使用unix行尾方式, 为了支持#! /usr/bin/env python
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
    set path+=C:\\Program\\\ Files\\\ (x86)\\Microsoft\\\ Visual\\\ Studio\\\ 14.0\\VC\\include
    set path+=C:\\Program\\\ Files\\\ (x86)\\Microsoft\\\ SDKs\\Windows\\v7.1A\\Include
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

" 窗口目录
function! WindowDir()
    if winbufnr(0) == -1
        let unislash = getcwd()
    else 
        let unislash = fnamemodify(bufname(winbufnr(0)), ":p:h")
    endif
    return tr(unislash, "\\", "/")
endfunc

" 向上查找文件
function! FindInParent(fln, flsrt, flstp)
    let here = a:flsrt
    while (strlen(here) > 0)
        if filereadable(here . "/" . a:fln)
            return here
        endif
        let fr = match(here, "/[^/]*$")
        if fr == -1
            break
        endif
        let here = strpart(here, 0, fr)
        if here == a:flstp
            break
        endif
    endwhile
    return "Nothing"
endfunc

" 关闭其他所有缓冲区
function! CloseAllBuffersButCurrent()
    let curr = bufnr("%")
    let last = bufnr("$")
    if curr > 1 | silent! execute "1," . (curr - 1) . "bd" | endif
    if curr < last | silent! execute (curr + 1) . "," . last . "bd" | endif
endfunction
nnoremap <leader>c :call CloseAllBuffersButCurrent()<cr>

"-------------------------------------------------------------------------------
" 插件
"-------------------------------------------------------------------------------

" a
set runtimepath+=~/dotfiles/bundle/a.vim

" mru
set runtimepath+=~/dotfiles/bundle/mru
if has("win32")
    let MRU_Exclude_Files = "*.svn\\.*|^C:\\Windows\\Temp\\.*"
else
    let MRU_Exclude_Files = "*.svn/.*|^/tmp/.*\|^/var/tmp/.*\|^/var/folders/.*"
endif

" nerdtree
set runtimepath+=~/dotfiles/bundle/nerdtree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
map <c-n> :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" supertab
set runtimepath+=~/dotfiles/bundle/supertab
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" vim-bookmarks
function! g:BMWorkDirFileLocation()
    let bmw = FindInParent(".vim-bookmarks", WindowDir(), $HOME)
    if bmw == "Nothing"
        for root in [".git", ".svn"]
            let location = finddir(root, ".;")
            if len(location) > 0
                let bmw = substitute(location, ".git", "", "")
                break
            endif
        endfor
    endif
    if bmw == "Nothing"
        return g:bookmark_auto_save_file
    else
        return bmw . "/.vim-bookmarks"
    endif
endfunction
set runtimepath+=~/dotfiles/bundle/vim-bookmarks
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1

" ctrlp
set runtimepath+=~/dotfiles/bundle/ctrlp.vim
let g:ctrlp_max_files = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
 \ "dir":  "\v[\/]\.(git|hg|svn)$|Temp|Library",
 \ "file": "\v\.(exe|so|dll|meta|png|jpg|prefab|mat|unity|mp3|mp4|wav|anim|fbx|asset|csproj|bytes|db)$",
 \ "link": "SOME_BAD_SYMBOLIC_LINKS",
 \ }

" vim-reveal-in-finder
set runtimepath+=~/dotfiles/bundle/vim-reveal-in-finder
nnoremap <leader><cr> :Reveal<cr>

" YouCompleteMe
set runtimepath+=~/dotfiles/bundle/YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_use_ultisnips_completer = 0
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
