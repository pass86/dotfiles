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

" 高亮当前行, NOTE: 会导致画面重绘变慢
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
set directory=~/.vim/tmp

" 备份文件(file~)存放目录, 空表示不生成备份文件
set backupdir=~/.vim/backup

" 重做文件(.file.un~)存放目录, 空表示不生成重做文件
set undodir=~/.vim/undo

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
"set dictionary+=~/.vim/dictionary/2+2gfreq.txt

" 从当前文件所在目录开始向上搜索tags, NOTE: ;代表了向上搜索
set tags=tags;

" 颜色数
set t_Co=256

" 使用系统剪切板, tmux on macos need install https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
set clipboard=unnamed

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"-------------------------------------------------------------------------------
" 杂项
"-------------------------------------------------------------------------------

" 打开语法高亮
syntax on

" 平台特性
if has("win32")
    source $VIMRUNTIME/mswin.vim
    source $VIMRUNTIME/vimrc_example.vim

    " set message language  
    let $LANG='en'

    " set menu's language of gvim. no spaces beside '=' 
    set langmenu=en

    behave mswin
endif

" 快速编辑vimrc
if has("win32")
    " 快速加载vimrc 
    map <silent> <leader>ss :source ~/_vimrc<cr>
    " 快速编辑vimrc 
    map <silent> <leader>ee :e ~/_vimrc<cr>
    " vimrc修改后马上加载
    autocmd! bufwritepost _vimrc source ~/_vimrc
else
    " 快速加载vimrc 
    map <silent> <leader>ss :source ~/.vimrc<cr>
    " 快速编辑vimrc 
    map <silent> <leader>ee :e ~/.vimrc<cr>
    " vimrc 修改后马上加载
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

if has("win32")
    " 最大化窗口
    au GUIEnter * simalt ~x 

    " 解决控制台中文乱码
    set termencoding=chinese

    " Windows默认设置到了$HOME/vimfiles, 统一设置到$HOME/.vim
    set runtimepath=~/.vim,$VIMRUNTIME

    " 搜索路径
    set path+=C:\\Program\\\ Files\\\ (x86)\\Microsoft\\\ Visual\\\ Studio\\\ 14.0\\VC\\include
    set path+=C:\\Program\\\ Files\\\ (x86)\\Microsoft\\\ SDKs\\Windows\\v7.1A\\Include
    set path+=$BOOST_ROOT
    set path+=$PROTOBUF_ROOT\\src

    if has('gui_running')
        " 不显示菜单栏、工具栏
        set guioptions=""

        " 字体
        set guifont=Source\ Code\ Pro,Consolas
        
        " 配色方案
        "set background=dark
        "set background=light

        " 不用斜体
        "let g:solarized_italic = 0
        "colorscheme solarized

        "colorscheme molokai
        "colorscheme PaperColor
    endif
else
    set path+=/usr/local/include
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" protobuf语法高亮
augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" python脚本使用unix行尾方式, NOTE: 为了支持#! /usr/bin/env python
augroup filetype
    au! BufRead,BufNewFile *.py set fileformat=unix
augroup end

" 启用文件类型插件和缩进
filetype plugin indent on

"-------------------------------------------------------------------------------
" 工具函数
"-------------------------------------------------------------------------------

" 窗口目录
function! WindowDir()
    if winbufnr(0) == -1
        let unislash = getcwd()
    else 
        let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
    endif
    return tr(unislash, '\', '/')
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

" 向上加载文件(如果有的话)
function! SourceInParent(fln)
    let dir = FindInParent(a:fln, WindowDir(), $HOME)
    if dir != "Nothing"
        let file = dir . "/" . a:fln
        if filereadable(file)
	        execute 'source ' . file
        endif
    endif
endfunc

" 关闭其他所有缓冲区
function! CloseAllBuffersButCurrent()
    let curr = bufnr("%")
    let last = bufnr("$")
    if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
    if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

" 快捷键
nnoremap <leader>c :call CloseAllBuffersButCurrent()<CR>

"-------------------------------------------------------------------------------
" MRU
"-------------------------------------------------------------------------------

" 排除临时文件
if has("win32")
    let MRU_Exclude_Files = '*.svn\\.*|^C:\\Windows\\Temp\\.*'
else
    let MRU_Exclude_Files = '*.svn/.*|^/tmp/.*\|^/var/tmp/.*\|^/var/folders/.*'
endif

"-------------------------------------------------------------------------------
" Tag List
"-------------------------------------------------------------------------------

" 打开获得焦点
let Tlist_GainFocus_On_ToggleOpen = 1

" 显示在右边
let Tlist_Use_Right_Window = 1

" 当只有Tag List窗口时退出
let Tlist_Exit_OnlyWindow = 1

" 只显示一个文件的Tag List
let Tlist_Show_One_File = 1

" 选择后关闭Tag List窗口
let Tlist_Close_On_Select = 1

" 切换Tag List显示
nnoremap <leader>g :TlistToggle<CR>

"-------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/nerdtree

" 显示隐藏文件
let NERDTreeShowHidden = 1

" 打开文件时关闭NERDTree窗口
let NERDTreeQuitOnOpen = 1

" 快捷键
map <C-n> :NERDTreeToggle<CR>

" 当只有NERDTree窗口时退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-------------------------------------------------------------------------------
" AutoComplPop
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/AutoComplPop

"-------------------------------------------------------------------------------
" YouCompleteMe
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/YouCompleteMe

" 发现.ycm_extra_conf.py不用确定提示
let g:ycm_confirm_extra_conf = 0

" 错误或警告不高亮行
let g:syntastic_enable_highlighting = 0

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " Do Mac stuff here
        let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf_macos.py"

        " 搜索路径
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/8.0.0/include
        set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
        set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
    endif
elseif has("win32")
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf_windows.py"
endif

" 跳转到定义
nnoremap <leader>jd :YcmCompleter GoTo<CR>

"-------------------------------------------------------------------------------
" cscope
"-------------------------------------------------------------------------------

" 快捷键
silent! map <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
silent! map <C-\>i :cs find i <C-R>=expand("<cword>")<CR><CR>

"-------------------------------------------------------------------------------
" autoload_cscope
"-------------------------------------------------------------------------------

" 不显示菜单
let g:autocscope_menus = 0

"-------------------------------------------------------------------------------
" tasklist
"-------------------------------------------------------------------------------

" 任务列表显示在底部
let g:tlWindowPosition = 1

"-------------------------------------------------------------------------------
" CCTree
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/CCTree

" 最大调用深度
let g:CCTreeRecursiveDepth = 5

" 最小显示深度
let g:CCTreeMinVisibleDepth = 5

" 显示在右侧
let g:CCTreeOrientation = "rightbelow"

" 查看调用自己 Ctrl+\ r
silent! map <C-\>r :CCTreeTraceReverse <C-R>=expand("<cword>")<CR><CR>

" 加载CCTree数据(如果有的话)
function! LoadCCTree()
    if filereadable('cscope.out')
        CCTreeLoadDB cscope.out
    endif
endfunc
autocmd VimEnter * call LoadCCTree()

" 加载CCTree数据, 向上查找
function! LoadCCTreeParent()
    let newcsdbpath = FindInParent("cscope.out",WindowDir(),$HOME)
    if newcsdbpath != "Nothing"
        let b:csdbpath = newcsdbpath
        "CCTreeLoadDB b:csdbpath . "cscope.out"
    endif
endfunc

" 自动加载CCTree数据
augroup AutoLoadCCTree
    au!
    au BufEnter *.cc call LoadCCTreeParent()
    au BufEnter *.[chly] call LoadCCTreeParent()
augroup END

"-------------------------------------------------------------------------------
" SuperTab
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/supertab

" 回车退出补全模式并保留当前文本
let g:SuperTabCrMapping = 1

" 从上往下选择, NOTE: 默认是从下往上选择
let g:SuperTabDefaultCompletionType = "<C-n>"
let g:SuperTabContextDefaultCompletionType = "<C-n>"

"-------------------------------------------------------------------------------
" vim-bookmarks
"-------------------------------------------------------------------------------

" 获得工作目录的书签路径
function! g:BMWorkDirFileLocation()
    let bmw = FindInParent(".vim-bookmarks",WindowDir(),$HOME)
    if bmw == "Nothing"
        let bmw = FindInParent("workspace.vim",WindowDir(),$HOME)
        if bmw == "Nothing"
            if isdirectory('.git') || isdirectory('.svn')
                " Current work dir is git's work tree
                let bmw = getcwd()
            else
                " Look upwards (at parents) for a directory named '.git'
                let location = finddir('.git', '.;')
                if len(location) > 0
                    let bmw = substitute(location, ".git", "", "")
                else
                    let location = finddir('.svn', '.;')
                    if len(location) > 0
                        let bmw = substitute(location, ".svn", "", "")
                    endif
                endif
            endif
        endif
    endif

    if bmw == "Nothing"
        return g:bookmark_auto_save_file
    else
        return bmw . "/.vim-bookmarks"
    endif
endfunction

" 加载插件
set runtimepath+=~/.vim/bundle/vim-bookmarks

" 选择后关闭书签窗口
let g:bookmark_auto_close = 1

" 高亮书签所在行
let g:bookmark_highlight_lines = 1

" 保存到工作目录
let g:bookmark_save_per_working_dir = 1

"-------------------------------------------------------------------------------
" ctrlp
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/ctrlp

" 不限制搜索文件数
let g:ctrlp_max_files = 0

" 搜索文件名, 默认是搜索路径
let g:ctrlp_by_filename = 1

" 自定义忽略
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|Temp|Library',
  \ 'file': '\v\.(exe|so|dll|meta|png|jpg|prefab|mat|unity|mp3|mp4|wav|anim|fbx|asset|csproj|bytes|db)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

" UltiSnips
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/ultisnips

" 展开片段
let g:UltiSnipsExpandTrigger = "<C-j>"

"-------------------------------------------------------------------------------
" vim-snippets
"-------------------------------------------------------------------------------

" 加载插件
set runtimepath+=~/.vim/bundle/vim-snippets

"-------------------------------------------------------------------------------
" vim-youdao-translater
"-------------------------------------------------------------------------------

" 快捷键
vnoremap <silent> <C-t> :<C-u>Ydv<CR>
nnoremap <silent> <C-t> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

"-------------------------------------------------------------------------------
" vim-reveal-in-finder
"-------------------------------------------------------------------------------

" 快捷键
nnoremap <leader><CR> :Reveal<CR>

"-------------------------------------------------------------------------------
" 最后处理
"-------------------------------------------------------------------------------

" 加载工程配置(如果有的话)
call SourceInParent("workspace.vim")

" 加载会话配置(如果有的话)
call SourceInParent("session.vim")
