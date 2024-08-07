" ==============================================================================
" author: RyanXu
" email: ryanxu1024@gmail.com
" ==============================================================================

" 关闭兼容vi模式
set nocompatible

" ==============================================================================
" UI 和基本配置
" ==============================================================================
" 让配置变更立即生效
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 定义快捷键前缀，即<Leader>
let mapleader=";"
let g:mapleader=";"
  
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应插件
filetype plugin on
" 自适应不同语言的智能缩进
filetype indent on

" 设置快捷键将选中文本块复制到系统剪切板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪切板内容粘贴到vim
nnoremap <Leader>p "+p

" 配色方案
set background=dark
colorscheme desert
"colorscheme molokai

" 总是显示状态行
set laststatus=2
" 状态行格式
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
" set cursorline
" set cursorcolumn
" 禁止折行
set nowrap
" turn of mouse
set mouse-=a
" 显示普通模式未完成的指令（一般是右下角显示）
set showcmd
" 在命令模式下按 Tab 键，展示候选词
set wildmenu

" ==============================================================================
" 编辑器配置
" ==============================================================================
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让vim把连续数量的空格视为一个制表符
set softtabstop=4
" 当输入超过78个字符并按下空格键时会自动换行
set textwidth=78
" 在插入模式下，删除键可以删除任何字符
set backspace=indent,eol,start

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动vim时关闭折叠代码
set nofoldenable
"  操作：za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

" 重新打开文件定位到上次位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ==============================================================================
" 编码
" ==============================================================================
" vim内部使用的字符编码
set encoding=utf-8
" 设置编辑文件时编码
set fileencoding=utf-8
" 文件编码类型侦测列表
set fileencodings=utf-8,ucs-bom,cp936,gb18030,gb2312,big5,euc-jp,euc-kr,latin1
" 终端显示使用的字符编码
set termencoding=utf-8
" let &termencoding=&encoding
" 防止特殊符号无法显示
" set ambiwidth=double

" ==============================================================================
" 搜索和匹配
" ==============================================================================
" 开启实时搜索功能
set incsearch
" 搜索时忽略大小写
set ignorecase
" 输入大写字母不忽略大小写
set smartcase
" 设置搜索高亮
set hlsearch
" 高亮显示匹配的括号
set showmatch

" ==============================================================================
" cscope配置 (cscope_maps.vim)
" ==============================================================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " Look for a 'cscope.out' file starting from the current directory,
    " going up to the root directory.
    let s:dirs = split(getcwd(), "/")
    while s:dirs != []
        let s:path = "/" . join(s:dirs, "/")
        if (filereadable(s:path . "/cscope.out"))
            execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
            break
        endif
        let s:dirs = s:dirs[:-2]
    endwhile

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-/>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-/>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-/>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


" ==============================================================================
" 插件管理
" ==============================================================================
if isdirectory(expand('~/.vim/bundle/Vundle.vim'))

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'

    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'

    call vundle#end()            " required

    " -------------------------------------------------------------------------------
    "  nerdtree
    " -------------------------------------------------------------------------------
    let g:NERDTreeChDirMode = 2  "Change current folder as root
    " let NERDTreeChDirMode=2
    " 打开vim时如果没有指定文件自动打开NERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    " 当NERDTree为剩下的唯一窗口时自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " 将F2设置为开关NERDTree的快捷键
    nnoremap <F7> :NERDTreeMirror<CR>
    nnoremap <F7> :NERDTreeToggle<CR>
    " 修改树的显示图标
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '-'
    " 窗口位置
    let g:NERDTreeWinPos='left'
    " 窗口尺寸
    let g:NERDTreeSize=30
    " 窗口是否显示行号
    let g:NERDTreeShowLineNumbers=1
    " 不显示隐藏文件
    let g:NERDTreeHidden=0

    " -------------------------------------------------------------------------------
    "  tagbar
    " -------------------------------------------------------------------------------
    nmap <F9> :TagbarToggle<CR>
    " 启动时自动focus
    let g:tagbar_autofocus=1
    let g:tagbar_width=30

else
    " echo "Vundle is not installed. Skipping Vundle initialization."
endif
