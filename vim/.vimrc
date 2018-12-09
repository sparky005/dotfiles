set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Bundle "daylerees/colour-schemes", { "rtp": "vim/" }
"Plugin 'Valloric/YouCompleteMe' just stops working al the time
Plugin 'w0rp/ale' "linter, i want to check it out
Plugin 'rust-lang/rust.vim'
Plugin 'Tagbar'
Plugin 'vim-airline/vim-airline'
"Plugin 'Syntastic' syntax checks, dont like it
Plugin 'jreybert/vimagit'
Plugin 'fugitive.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'tmhedberg/SimpylFold'
Bundle 'gabrielelana/vim-markdown'
"Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'euclio/vim-markdown-composer' " requires a rust package
Bundle 'https://github.com/hashivim/vim-terraform'
Bundle 'https://github.com/itchyny/vim-haskell-indent'
" dart lang
Plugin 'dart-lang/dart-vim-plugin'
if has('nvim')
  " if using nvim
  " all these providers require external setup. ugh
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plugin 'zchee/deoplete-jedi'
  Bundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}
  Plugin 'sebastianmarkow/deoplete-rust'
else
" plugins for deoplete
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
endif
colorscheme wal

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end() " required

filetype plugin indent on " required
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" basic configuration settings
set hidden "allow hidden buffers
set autoread
" syntax highlighting
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set softtabstop=4
colorscheme elflord
"colorscheme mellow-contrast
set guifont=Monospace\ 12

" let ctrl+l leave insert mode
imap <C-L> <Esc>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" esc should exit terminal mode
tnoremap <Esc> <C-\><C-n>


" deocomplete settings
" should prevent issues with conda environments
" required for deocomplete and deocomplete-jedi
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
let g:deoplete#enable_at_startup = 1
" go plugin
let g:deoplete#sources#go#gocode_binary = "$HOME/go/bin/gocode"
" hide panel when done inserting
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" change deoplete key to tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" deoplete-rust
let g:deoplete#sources#rust#racer_binary='$HOME/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='$HOME/repos/rust/src'



" YCM config
let g:ycm_autoclose_preview_window_after_insertion= 1
let g:ycm_show_diagnostics_ui = 0 " leaving this enablbed breaks syntastic
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python'


" tagbar
nmap <F8> :TagbarToggle<CR>
" tagbar for golang (requires https://github.com/jstemmer/gotags)
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
    \ }
" highlighting of current line
set cursorline


" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#vimagit#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1 "enables ALE support
let g:airline_theme='wal'

" ale options
let g:ale_lint_on_text_changed = 'always' " stop linting on every edit
let g:ale_lint_on_insert_leave  = 1 " lint after exiting insert mode

"gitgutter setings
"let g:gitgutter_realtime = 1
"set updatetime=550


" buffergator
let g:buffergator_viewport_split_policy = "B"
let g:buffergator_hsplit_size = 5


" vim markdown preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let vim_markdown_preview_use_xdg_open=1

" dart thingy
"let dart_style_guide = 2
