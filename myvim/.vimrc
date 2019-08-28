set nocompatible " 關閉與vi的兼容模式
filetype off

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }  " 在nerdtree中顯示git的檔案變化
Plug 'airblade/vim-gitgutter'         " 在最左側顯示git的修改記錄
Plug 'tpope/vim-fugitive'             " git 的增強 Plugin
Plug 'w0rp/ale'                       " 程式碼檢查
Plug 'Yggdroot/indentLine'            " 加入outline
Plug 'vim-airline/vim-airline'        " 狀態欄
Plug 'vim-airline/vim-airline-themes' " 狀態欄themes
"Plug 'pearofducks/ansible-vim'        " syntax highlight for ansible
Plug 'pangloss/vim-javascript'        " javascript highlighting & indentation
Plug 'othree/javascript-libraries-syntax.vim' " Syntax for some JS libraries
Plug 'mxw/vim-jsx'                    " jsx highlight
Plug 'towolf/vim-helm'                " highlight helm
Plug 'morhetz/gruvbox'                " color theme
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'           " autocomplete for quotes, brackets, etc
Plug 'sickill/vim-pasta'              " enhanced paste
Plug 'tpope/vim-surround'             " delete, change and insert surroundings
Plug 'lifepillar/vim-mucomplete'      " Completion wrapper
Plug 'ludovicchabant/vim-gutentags'   " for ctags
Plug 'easymotion/vim-easymotion'      " for motion
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " vim golang plugin
call plug#end()

filetype plugin indent on

" **************************
" Basic Setup
" **************************

" Encoding
set encoding=utf-8       " 編碼
set fileencoding=utf-8   " 編碼
set fileencodings=utf-8  " 編碼

" Fix backspace indent
set backspace=indent,eol,start
set cindent            " 自動縮排

" Tabs
set expandtab          " tab替換为空格键

" Map leader
let mapleader = ','
let maplocalleader = ','

" Searching
set hlsearch           " 搜尋高亮
set incsearch          " 直接搜尋
set ignorecase         " 搜尋忽略大小寫
set smartcase          " 但有大寫字母時不忽略
set wildignore=*/node_modules/*,*/dist/*  " 搜尋時排除位置

" Swap, backup, undo
set backupdir=~/.vim/backup//  " 讓vim 生成的~文件在指定位置
set directory=~/.vim/swap//    " 讓vim 生成的swp檔在指定位置
set undodir=~/.vim/undo//      " 讓vim 生成的un檔在指定位置

" window splits
set splitbelow
set splitright

" language
set langmenu=en_US     " 設定語言
let $LANG='en_US'

" tab, end, trail space
set list listchars=eol:¬,tab:▸\ ,trail:▵, " 顯示tab, 行尾空格, 行結束符

" fold
" set foldmethod=indent  " 設定折疊
" set foldlevel=1

" operation
set confirm            " 遇到需確認動作時詢問
" set autowrite          " 失焦時自動存檔
set autoread           " 檔案在其他地方修改時自動更新
set updatetime=100     " 更新時間100ms

set showmatch
set matchtime=1        " 顯示括號配對位置

set showcmd            " 在右下角顯示現有命令
set clipboard=unnamed  " 共用系統剪貼簿
set switchbuf+=usetab,newtab  "將quickfix開至新tab上
set omnifunc=syntaxcomplete#Complete
set completeopt+=menuone  " for vim-mucomplete"


" **************************
" Visual Settings
" **************************
syntax on
set ruler
set number             " 顯示相對行號
set conceallevel=0     " show quote in json file, it doesn't work

" colorful
if has('termguicolors')
    set termguicolors  " enable true color
endif

set t_Co=256
colorscheme gruvbox   " theme
"colorscheme codedark   " theme

" Scroll
set scrolloff=3        " 距離頂部和底部3行
set ttyfast            " 改善 scrolling

" Status bar
set laststatus=2    " 永遠顯示狀態欄

"change cursor display
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"



" *******************************
" Package Setting
" *******************************

"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2

" =============================================================================
" Silver Searcher
" =============================================================================
" need installed silver-searcher
if executable('ag')
  " set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ node_modules
  " set grepprg=ag\ --nogroup\ --ignore\ node_modules
  set grepprg=ag

  " Use CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " no cache
  " 我們大菁英sliver serch不需要cache加快速度
  let g:ctrlp_use_caching = 0

endif

" =============================================================================
" ale
" =============================================================================

let g:ale_fixers = {
\       '*': ['remove_trailing_lines', 'trim_whitespace'],
\       'javascript': ['prettier', 'eslint'],
\}

let g:ale_linters = {
\   'javascript':['eslint'],
\}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" for go to define
let g:ale_completion_enabled = 1

"let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
noremap <Leader>gd :ALEGoToDefinition<CR>
noremap <Leader>gr :ALEFindReferences<CR>
noremap <leader>fix :ALEFix<CR>

" =============================================================================
" vim-airline start
" =============================================================================
let g:airline_powerline_fonts = 1    " 支援 powerline 字體

let g:airline#extensions#tabline#enabled = 1 " 顯示 tab 視窗及 buffer
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 0

let g:airline#extensions#bufferline#enabled = 0

let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#ale#enabled = 1


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='bubblegum'


" =============================================================================
" NERDTree Settings
" =============================================================================
let g:NERDTreeWinSize=25
let g:NERDTreeChDirMode=2
let g:NERDTreeShowHidden=1

" map :NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>
" 切換到該文件在 NERDTree 中的位置
nnoremap <leader>nf :NERDTreeFind<cr>

" =============================================================================
" vim-gitgutter ====
" =============================================================================
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
nmap <leader>nc <Plug>GitGutterNextHunk
nmap <leader>pc <Plug>GitGutterPrevHunk

" =============================================================================
" ctags
" =============================================================================
nnoremap <silent><C-]> <C-w><C-]><C-w>T


" *****************************************************************************
" movement
" *****************************************************************************
" 折行移動
nnoremap j gj
nnoremap k gk

" 快速切換視窗
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 調整 window 大小
nnoremap <silent> <Leader>vs :vertical resize -10<CR>
nnoremap <silent> <Leader>vp :vertical resize +10<CR>

" 將當下字串全部改成大寫
" nnoremap ,u viwUe
" inoremap ,u <esc>viwUea

" map <esc> in insert/visual mode
inoremap jk <esc>
vnoremap jk <esc>

" 快速編輯.vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" combine Tabs
nnoremap ,tp :call MoveToPrevTab()<CR>
nnoremap ,tn :call MoveToNextTab()<CR>
nnoremap ,tc :tabclose<CR>

nnoremap ,op c:vsp#<CR>

" hard way
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

augroup closeNerdTree
        autocmd!
        autocmd bufenter *
        \ if ( winnr("$") == 1 &&
        \      exists("b:NERDTree") &&
        \      b:NERDTree.isTabTree())
        \ | q | endif
augroup END

augroup filetypeSet
        autocmd!
        " 開啟helm yaml, tpl 檔時，套用以下規則
        autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl set ft=helm

        " 開啟.py 時使用下列設定
        au BufNewFile,BufRead *.py
            \ set fileformat=unix |  " 保存文件格式
            \ set tabstop=4       |  " tab 寬度
            \ set softtabstop=4   |
            \ set shiftwidth=4
            \ set textwidth=79
            \ set expandtab
            \ set autoindent

        " 開啟.js .jsx 時使用下列設定
        au BufNewFile,BufRead *.js,*.jsx,*.lua,*.html
            \ set tabstop=2      |
            \ set softtabstop=2  |
            \ set shiftwidth=2   |
            \ set autoindent

        " 開啟 javascript 檔時，套用以下快捷鍵
        "au FileType javascript nnoremap <buffer> <localleader>c _i//<esc>
        "

        " 開啟.go 時使用下列設定
        au BufNewFile,BufRead *.go
            \ set tabstop=4     |
            \ set shiftwidth=4  |
            \ set expandtab     |
            \ set autoindent 
augroup END

" ------ Function Block -----
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
" ------ Block End -----
