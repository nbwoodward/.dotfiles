autocmd VimEnter * echo 'running nvim'
"nvim calls ~/.config/nvim/init.vim
source ~/.vimrc

"call plug#begin('~/.vim/plugged')
"" Plugins will go here in the middle.
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tmux-plugins/vim-tmux-focus-events'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'roxma/vim-tmux-clipboard'
"Plug 'JuliaEditorSupport/julia-vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'tpope/vim-fugitive'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'majutsushi/tagbar'
"Plug 'bronson/vim-trailing-whitespace'
"call plug#end()
"
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"
"au VimEnter *  NERDTree
"autocmd VimEnter *  wincmd p "focuses on buffer
"autocmd VimEnter {}  wincmd p "if empty, focuses back on nerdtree
