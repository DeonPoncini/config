" vim plugin manager
set nocompatible
filetype indent plugin on
syntax on

function! s:SetupVAM()
    let c = get(g:, 'vim_addon_manager', {})
    let g:vim_addon_manager = c
    let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
    let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
    if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
        execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
          \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
    endif
    call vam#ActivateAddons([], {'auto_install' : 0})
endfun
call <SID>SetupVAM()

" Download plugins
ActivateAddons The_NERD_tree        " file browser
ActivateAddons fugitive             " git integration
ActivateAddons Conque_Shell         " run bash terminal
ActivateAddons powerline            " status line
ActivateAddons FuzzyFinder          " quick file opening
ActivateAddons molokai              " colorscheme
ActivateAddons YouCompleteMe        " clang code complete
ActivateAddons cmake%600            " cmake syntax highlight
ActivateAddons Align%294            " column alignment
ActivateAddons grep                 " searching
ActivateAddons slang_syntax         " GLSL syntax highlight
ActivateAddons pathogen             " for plugins VAM doesn't cover

execute pathogen#infect()

" Setup look and feel
set number              " Turn on line numbering
set autoindent          " Indent automatically depending on filetype
set expandtab           " Replace tabs with spaces
set shiftwidth=4        " tab width of 4
set tabstop=4           " tab width of 4
set ic                  " Case insensitive search
set hls                 " Highlight search
set incsearch           " Highlight search as we type
set lbr                 " Wrap text instead of being on one line
set background=dark     " dark background
colorscheme molokai     " Change colorscheme from default
set t_Co=256            " 256 color terminal
set cursorline          " Highlight current line
set laststatus=2        " always show status line
set autowrite           " save when switching buffers
set encoding=utf-8      " full unicode support
set colorcolumn=81      " put a line at column 81
set previewheight=30    " enlarge the preview window
let mapleader=","       " map leader for bindings
let maplocalleader="\\" " map local leader

" keybindings
" utility
nnoremap ; :
inoremap jk         <ESC>
inoremap kj         <ESC>
inoremap <ESC>      <NOP>
nnoremap <Right>    <C-PageDown>
nnoremap <Left>     <C-PageUp>
nnoremap <Up>       <NOP>
nnoremap <Down>     <NOP>
inoremap <Right>    <Esc><C-PageDown>
inoremap <Left>     <Esc><C-PageUp>
" move lines up and down
nnoremap + o<Esc>kddp
nnoremap _ kdd
nnoremap = i<Space><Esc>l
nnoremap - hx
" window movement
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
" tag navigation
noremap <F2>   :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
noremap <F3>   :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" file browsing
noremap <F4>   :FufCoverageFile<CR>
" vimrc quicklinks
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" deleters
onoremap p i(
onoremap b i{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>

" autoremove whitespace
augroup formatters
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" setup clang integration
let g:clang_library_path='/usr/lib/llvm-3.3/lib/'
let g:clang_user_options='|| exit 0'

" per language auto comments
augroup comments
autocmd!
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType c          nnoremap <buffer> <localleader>c I/*<esc>A*/<esc>
autocmd FileType html       nnoremap <buffer> <localleader>c I<!--<esc>A--><esc>
autocmd FileType cpp        nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType java       nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<eSc>
autocmd FileType sh         nnoremap <buffer> <localleader>c I#<eSc>
augroup END

" various toggles
nnoremap <leader>N :set number!<cr>

function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

let g:vimrc_quickfix_is_open = 0
function! s:QuickFixToggle()
    if g:vimrc_quickfix_is_open
        cclose
        let g:vimrc_quickfix_is_open = 0
        execute g:vimrc_quickfix_return_to_window . "wincmd w"
    else
        let g:vimrc_quickfix_return_to_window = winnr()
        copen
        let g:vimrc_quickfix_is_open = 1
    endif
endfunction

nnoremap <leader>q :call <SID>QuickFixToggle()<cr>

command SetGLSLFileType call SetGLSLFileType()
function! SetGLSLFileType()
  for item in getline(1,10)
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
    endif
    if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
  endfor
endfunction
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl SetGLSLFileType
