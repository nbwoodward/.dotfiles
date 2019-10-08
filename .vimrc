,
" Default plugins using VimPlug
"
" Install with :PlugInstall
" Update with :PlugUpdate
"
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-sleuth'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'bronson/vim-trailing-whitespace'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"
" NerdTree configuration.
"
"au VimEnter *  NERDTree "Auto open NERDTree when opening vim.
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinPos = "right"
autocmd VimEnter *  wincmd p "when opening vim with a file, focuses on buffer
autocmd VimEnter {}  wincmd p "when opening empty vim , focuses on nerdtree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Not sure what this does


"shorten how fast vim updates
set updatetime=1000

"file encrypiton
if !has('nvim')
	set cryptmethod=blowfish2
endif

"
" Template and default look/feel
"
colorscheme desert
set background=dark
hi DiffAdd guifg=NONE ctermfg=NONE guibg=#464632 ctermbg=238 gui=NONE cterm=NONE
hi DiffChange guifg=NONE ctermfg=NONE guibg=#335261 ctermbg=239 gui=NONE cterm=NONE
hi DiffDelete guifg=#f43753 ctermfg=203 guibg=#79313c ctermbg=237 gui=NONE cterm=NONE
hi DiffText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=reverse cterm=reverse


set nowrap "Don't wrap long lines
set hlsearch "Highlight search terms
set modelines=0 "Do not allow custom vim lines in files, see https://vim.fandom.com/wiki/Modeline_magic
set mouse=a "Allow mouse on all modes
set showmatch "When cursor is on a brace, highlight the matching brace
set matchtime=5 "Set match time to show when creating a matching brace
set ignorecase "Ignores case when searching
set smartcase "Ignores case when searching unless search term has uppercase
set autoindent "Automatically indent on new line
set smartindent "Smartly indent, autoindent should also be set.
set scrolloff=5 "How many lines to keep below and above cursor when scrolling.
set tabstop=4 "Default 4 spaces for tabs
set shiftwidth=4 "Default shift width
set expandtab "Use spaces instead of tabs
set smarttab "smartly use spaces and tabs.

autocmd FileType elixir setlocal tabstop=2 shiftwidth=2

"SET NO ERROR BELLS
set noeb vb t_vb=

"Set relative line count
set number relativenumber
command! NN :set number! relativenumber!

"Prevent hiding of quotes on JSON and commas in CSV
set cole=0
au FileType * setl cole=0



"
" Commands to do things
"

"Set leader to ,
:let mapleader = ","


command! RS :FixWhitespace "Typing :RS removes trailing whitespace from lines in document
command! RM :mark z | :%s///g | :'z "Typing :RM removes ^M's from document, consenquence of windows/unix differences
command! RX :%s/XXX/\=printf("%d", line('.'))/g "Typing :RX swaps any XXX with the line number it's on
command! L :edit "Typing :L will refresh the document
command! S :setlocal spell! "Typing :S will toggle spell checking
command! Noh :noh "Just because I sometimes capitalize the :noh command
"Expand current pane to a new window
command! O :mark z | :tabedit % | :'z
"Close current expanded window
command! C :mark z | :tabclose | :'z | normal zz
" Doesn't seem to work like expected. Needs love.
"command! FORMAT :%s/\s\+$//e | :normal gg=G "Auto format a document, setting tabs correctly and... running that replace


nnoremap :W :w
nnoremap :Q :q
nnoremap <space> yiw

"Uncomment to use - and _ to move lines up and down
"nnoremap - ddp
"nnoremap _ ddkP

"Highlight a section and hit :NAC to comment out that section
vnoremap :NAC :normal @c
vnoremap :NAV :normal @v

vnoremap J j

nnoremap <leader>ev :sp ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>c :NERDTreeToggle<CR>
command! NL let g:NERDTreeWinPos = "left" | NERDTreeToggle | NERDTreeToggle | execute("normal \<C-w>p")
command! NR let g:NERDTreeWinPos = "right" | NERDTreeToggle | NERDTreeToggle | execute("normal \<C-w>p")
nnoremap <leader>v :TagbarToggle<CR>
hi TagbarHighlight term=reverse ctermfg=248 ctermbg=35 guifg=wheat guibg=peru
let g:tagbar_sort=0


noremap H ^
noremap L $
noremap K :echo "(>^.^<)"<cr>

" <leader>m and :M will run make in pane 1
"nnoremap <leader>m :!tmux send -t 1 'make' Enter <CR><C-L>
nnoremap <C-N> :!tmux send -t 1 'make' Enter <CR><C-L>
nnoremap <C-P> :!tmux send -t 2 C-p Enter <CR><C-L>
" For Elixir, set command to be recompile
au BufEnter *.ex*,*.eex nnoremap <buffer> <C-N> :!tmux send -t 1 'recompile' Enter <CR><C-L>
"au BufEnter *.go nnoremap <buffer> <C-N> :!tmux send -t 2 'go test -v ./...' Enter <CR><C-L>

"
" Environment Specific things
"

if has("macunix") "Special clipboard handling on Mac

	if has('nvim')
		set clipboard+=unnamedplus " Use system clipboard on osx
	else
		set clipboard+=unnamed " Use system clipboard on osx
	endif
elseif has("unix") "Can add special Linux handling here.
endif

"Tmux specific commands for running lines of code. Read about vim slime for usage.
if exists('$TMUX')
	let g:slime_target = "tmux"
	let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": "1"}
	let g:slime_dont_ask_default = 1
endif



"
" Language Specific commands
"


let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"Have these but we mapped leader-c to open/close nerdtree...
"autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
"autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

"Have this but shouldn't need it as these are defaults above.
"au BufEnter *.html setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

au BufEnter *.jl setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
au BufEnter *.ex* setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

"
"ALE Linter
"let g:ale_lint_on_text_changed=0
"autocmd FileType c :ALEEnable

"Make files depend on \t tabs so don't expand them
autocmd FileType make set noexpandtab



"Commenting macro @c
let @c='0i#j'
let @v='^v0xV=j'
autocmd FileType javascript let @c='0i//j'
autocmd FileType c++ let @c='0i//j'
autocmd FileType elixir let @c='I#j'

"function! FZFOpen(command_str)
  "if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    "exe "normal! \<c-w>\<c-w>"
  "endif
  "exe 'normal! ' . a:command_str . "\<cr>"
"endfunction
"nnoremap <silent> <leader>f :call FZFOpen(':Files')<cr>

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <C-f>F :FZF ~<cr>

command! FF :FZF
command! FI :Find
" Open files in horizontal split
nnoremap <silent> <Leader>sf :call fzf#run({ 'down': '40%', 'sink': 'belowright split' })<CR>

command! Gs :Gstatus
command! GS :Gstatus
command! Gd :Gdiff
command! GD :Gdiff

command! -bang -nargs=* R
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Go stuff
command! GOC :GoCoverageToggle

"TESTING RG STUFF

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

source ~/.vimrc.local
