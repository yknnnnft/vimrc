" Modified   @2017/03/29   setting tabline
" Modified   @2017/02/01
" Modified   @2017/01/07
" created    @2017/01/06


" ------------------------------------ "
"          basic configuration         "
" ------------------------------------ "
syntax on                                                                     " syntax highlight
syntax enable
set backspace=0                                                               " 0: ;1: indent, eol; 2: indent, eol, start
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ignorecase
set nohlsearch
set showcmd                                                                   " show command input
set ruler
set history=77                                                                " number of command/search history memorized
set cursorline                                                                " highlight selected line
set cursorcolumn
set scrolloff=3                                                               " scroll when 3 line from top/bottom
if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 12
else
    set guifont=Ubuntu_Mono:h12
end
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set iminsert=0
set imsearch=-1
set shortmess=atI
set go=
set novisualbell
set nowrap
set number
set splitright
set guicursor=n:block-blinkon0                                                " guiCursor = all-mode: block - blink on Interval 0
set guicursor+=i:block-iCursor-blinkwait300-blinkon400-blinkoff550            " guiCursor = all-mode: block - blink on Interval 0
set incsearch
set clipboard+=unnamedplus
let cobol_legacy_code=1
let g:prettier#config#tab_width=4                                             " number of spaces per indentation level
let g:prettier#config#trailing_comma = 'none'
if has('multi_lang')
    language C
endif
if has('win32')
    autocmd GUIEnter * simalt ~x                                              " full-screen mode
endif




" ------------------------------------ "
"        Vundle's Configuration        "
" ------------------------------------ "

filetype off                                                                  " be iMproved, required
set nocompatible                                                              " required

" set the runtime path to include Vundle and initialize
if has('win32')
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$HOME/vimfiles/bundle/')
elseif has('unix')
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif
set shortmess+=c                                                              " fix: User defined completion (^U^N^P) Pattern not found

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" NERD Tree
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinSize=26
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = $HOME
if has('win32')
    let g:ycm_global_ycm_extra_conf .= '\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\ycm\.ycm_extra_conf.py'
elseif has('unix')
    let g:ycm_global_ycm_extra_conf .= '/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif
" javasciprt syntax highlight
Plugin 'pangloss/vim-javascript'
" Plugin 'crusoexia/vim-javascript-lib'
" vim-easymotion
Plugin 'easymotion/vim-easymotion'
" vim-project
Plugin 'vim-scripts/project.tar.gz'
" vim-fugitive
Plugin 'tpope/vim-fugitive'
" open-browser
" Plugin 'tyru/open-browser.vim'
" vim-quickrun
Plugin 'thinca/vim-quickrun'
let g:quickrun_config={'_': {'split': 'botright 50vsplit'}}
if has('win32')
    Plugin 'kkoenig/wimproved.vim'
    " autocmd GUIEnter * WToggleFullscreen                                             " full-screen mode
    " fullscreen
    nnoremap <F11> :WToggleFullscreen<CR>
endif
" color-scheme
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'tomasr/molokai'
Plugin 'yknnnnft/vim-monokai'
" vim-prettier
Plugin 'prettier/vim-prettier'
" vim-go
Plugin 'fatih/vim-go'
call vundle#end()                                                             " required
filetype plugin indent on                                                     " required
autocmd FileType javascript setlocal omnifunc=tern#Complete



" ------------------------------------ "
"      Statusline Configuration        "
" ------------------------------------ "
set statusline=\ Row:%l,
set statusline+=Column:%v\ \|
set statusline+=%<\ <%F%m%r%h%w%q>
set statusline+=\ %=
set statusline+=%Y\ 
set statusline+=\ %{&fileformat}\ 
set statusline+=\ %{&fenc!=''?&fenc:&enc}\ 
set statusline+=\ %p%%
set statusline+=(in\ %L)\ 
set laststatus=2                     " 2: always

" ------------------------------------ "
"             Color-scheme             "
" ------------------------------------ "
set background=dark
" colorscheme solarized
" let g:solarized_termcolors=256
" colorscheme molokai
" let g:mololai_origin=1
colorscheme monokai
set t_Co=256
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1


" ------------------------------------ "
"           Gdiff-settings             "
" ------------------------------------ "
set diffopt+=vertical


" ------------------------------------ "
"             Session-make             "
" ------------------------------------ "
" set sessionoptions+=resize,winpos,winsize,blank,curdir,folds,help,tabpages,options
" if has('win32')
"     autocmd VimEnter * so $HOME\Session.vim
"     autocmd VimLeave * mks! $HOME\Session.vim
" elseif has('unix')
"     autocmd VimEnter * so $HOME/Session.vim
"     autocmd VimLeave * mks! $HOME/Session.vim
" endif

" ------------------------------------ "
"      fix window width for Project    "
" ------------------------------------ "
function! ToggleProjWFW()
    execute "silent normal \<Plug>ToggleProject"
    if exists('g:proj_running') && bufwinnr(g:proj_running) != -1
        set winfixwidth
    endif
endfunction

" ------------------------------------ "
"             Tabline-make             "
" ------------------------------------ "
set showtabline=2
set tabline=%!MakeTabLine()
function! s:tabpage_label(n)
    " t:title と言う変数があったらそれを使う
    let title = gettabvar(a:n, 'title')
    if title !=# ''
        return title
    endif
    let bufnrs = tabpagebuflist(a:n)                        " タブページ内のバッファのリスト
    let no = len(bufnrs)                                    " バッファが複数あったらバッファ数を表示
    " タブページ内に変更ありのバッファがあったら
    " '+' を付ける
    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let bufshow = '[' . no . mod . ']'
    let sp = ' '                                        " 隙間空ける  
    " カレントバッファ
    let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]            " tabpagewinnr() は 1 origin
    let fname = bufname(curbufnr)
    if a:n is tabpagenr()
        let hi = '%#TabLineSel#' " カレントタブページかどうかでハイライトを切り替える
        if fname ==# ''
            let fname = '<notitle>'
        else
            let fname = pathshorten(fname)
        endif
    else
        let hi = '%#TabLine#' " カレントタブページかどうかでハイライトを切り替える
        if fname ==# ''
            let fname = '<notitle>'
        else
            let fname = fnamemodify(fname, ':t')
        endif
    endif
    let label = ' ' . '=' . a:n . '=' . sp . bufshow . sp . fname . ' '
    return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
    let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let sep = '|'
    let tabpages = ''
    let tabpages .= titles[0]
    for t in range(2, tabpagenr('$'))
        let tabpages .= sep
        let tabpages .= titles[t - 1]
    endfor
    let tabpages .= '%#TabLineFill#%T'
    let info = ''
    let info .= '%#TabLineInfo#'
    let info .= '  '
    let info .= pathshorten(fnamemodify(getcwd(), ":~"))    " pwd
    let info .= ' ' . sep . ' ' . strftime("%y/%m/%d\ %H:%M") . ' '     " system time
    let info .= '%'
    return tabpages . '%=' . info                           " タブリストを左に、情報を右に表示
endfunction

" ------------------------------------ "
"             Key-Mapping              "
" ------------------------------------ "
" Ctrl+A
nmap <C-a>a ggVG$
if has('win32')
    nmap <C-a>c ggVG$"*y
    nmap <C-a>x ggVG$"*d
elseif has('unix')
    nmap <C-a>c ggVG$"+y
    nmap <C-a>x ggVG$"+d
endif
" Ctrl+E: NERDtree
nnoremap <silent><SPACE>tt :NERDTreeToggle<CR>
nnoremap <silent><SPACE>tf :NERDTreeFind<CR>
" Space: Leader
let mapleader = "\<Space>"
" auto-closing
inoremap { {}<LEFT>
inoremap {} {}
inoremap [ []<LEFT>
inoremap [] []
inoremap ( ()<LEFT>
inoremap () ()
inoremap " ""<LEFT>
inoremap "" ""
inoremap "<BS> "
inoremap "<C-h> "
inoremap "<SPACE> "<SPACE>
inoremap ' ''<LEFT>
inoremap '' ''
inoremap '<BS> '
inoremap '<C-h> '
inoremap '<SPACE> '<SPACE>
inoremap ` ``<LEFT>
" inoremap <> <><LEFT>
inoremap {<CR> {}<LEFT><CR><ESC>O
inoremap {<S-CR> {1<ESC>c$}<LEFT><CR><ESC>O<C-r>"<ESC>^xA
" add a null line
nnoremap <CR> o<ESC>
" del a char and move backward
nnoremap <BS> xl
" moving current line upward/downward
nnoremap <C-k> <ESC>kddpk
nnoremap <C-j> <ESC>ddp
inoremap <C-k> <ESC>kddpka
inoremap <C-j> <ESC>ddpa
" grep search
nnoremap <leader>n :cnext<CR>
nnoremap <leader>N :cprevious<CR>
" set current working directory
nnoremap <leader>pwd :lcd %:p:h<CR>
" call python3
nnoremap <leader>py :w<CR>:term python3 %<CR>
nnoremap <leader>term :term<CR>
" easy motion search motion
nmap <leader><leader>2f <Plug>(easymotion-f2)
nmap <leader><leader>2F <Plug>(easymotion-F2)
nmap <leader><leader>2s <Plug>(easymotion-s2)
nmap <leader><leader>nf <Plug>(easymotion-fn)
nmap <leader><leader>nF <Plug>(easymotion-Fn)
nmap <leader><leader>ns <Plug>(easymotion-sn)
nmap <leader><leader>l <Plug>(easymotion-wl)
nmap <leader><leader>h <Plug>(easymotion-bl)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
" highlight search automaticlly
nnoremap / :se hlsearch<CR>/
nnoremap <silent><ESC><ESC> :se nohlsearch<CR><ESC>
nnoremap <silent>n :se hlsearch<CR>n
nnoremap <silent>N :se hlsearch<CR>N
" highlight current word without losing cursor
nnoremap <silent><leader>sw :se hlsearch<CR>#*
" close tab
nnoremap <leader>tc :tabc<CR>
" open new tab
nnoremap <leader>te :tabe<CR>
" QuickRun
nnoremap <leader>kb :QuickRun<CR>
" Toggle Project window
nmap <silent><leader>P :call ToggleProjWFW()<CR>
" YouCompleteMe jump
nnoremap <silent><leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <silent><leader>gr :YcmCompleter GoToReferences<CR>
" reopen closed window
nnoremap <silent><leader>rw :vs#<CR>

