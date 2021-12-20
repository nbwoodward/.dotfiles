set t_ut=
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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'bronson/vim-trailing-whitespace'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cakebaker/scss-syntax.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set tabstop=2 "Default 4 spaces for tabs
set shiftwidth=2 "Default shift width
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
" nnoremap <leader>v :TagbarToggle<CR>
hi TagbarHighlight term=reverse ctermfg=248 ctermbg=35 guifg=wheat guibg=peru
let g:tagbar_sort=0


noremap H ^
noremap L $
" SHOW A KITTY ON THE ANNOYING KEYS
noremap K :echo "(>^.^<)"<cr>
noremap Q :echo "(>^.^<)"<cr>

au BufEnter * let testpath=""
" au BufEnter *xgps/*_test.exs let testpath=join(["test/",split(expand("%"), "/test/")[1]], "")
" au BufEnter *.test.js let testpath=join(["test/",split(expand("%"), "/test/")[1]], "")

function! RunTest()
  let targetPane = GetTargetTmuxPane()
  "Elixir
  if expand("%") =~ "_test.exs"
    let path = split(expand("%"), "/test/")
    if len(path) == 1
      let testpath=path[0]
    else
      let testpath=join(["test/",path[1]], "")
    endif
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " 'mix test --color ". testpath ." | grep -v \"Paths given to\"' Enter"
  elseif expand("%") =~ ".test.js"
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " 'npm run test' Enter"
  elseif expand("%") =~ "_test.go"
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " 'docker-compose run --rm test' Enter"
  else
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " C-p Enter"
  endif
endfunction

function! RunLint()
  let targetPane = GetTargetTmuxPane()
  if expand("%") =~ ".go"
    let lintpath=expand("%")
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " 'golint ". lintpath ."' Enter"
  else
    execute ":!tmux send -t " . targetPane . " C-c"
    execute ":!tmux send -t " . targetPane . " C-p Enter"
  endif
endfunction

function! GetTargetTmuxPane()
  let tmux_pane=system('tmux display -pt "${TMUX_PANE:?}" "#{pane_index}"')
  if tmux_pane == 2
    return 1
  else
    return 2
  endif
endfunction


nnoremap <C-T> :call GetTargetPane() <CR><C-L>

" <leader>m and :M will run make in pane 1
nnoremap <C-N> :!tmux send -t 1 'make' Enter <CR><C-L>
nnoremap <C-P> :call RunTest() <CR><C-L>
nnoremap <C-I> :call RunLint() <CR><C-L>

" For Elixir, set command to be recompile
au BufEnter *.ex*,*.eex nnoremap <buffer> <C-N> :!tmux send -t 1 'recompile' Enter <CR><C-L>
" For Elixir, format on file save
let g:mix_format_on_save = 0
let g:mix_format_silent_errors = 1

" Auto Formatting
" autocmd BufWritePost *.js,*.vue,*.ts silent call FormatJS()
" autocmd BufWritePost * silent call Format()

command! F silent call Format()
command! FF silent call FormatAll()

" Runs formatter for specific file types
function! Format()
  if &ft =~ 'javascript'
    call Preserve("!prettier --write '%:p'")
  elseif &ft =~ 'vue'
    call Preserve("!prettier --write '%:p'")
  elseif &ft =~ 'elixir'
    call Preserve("!mix format '%:p'")
  endif
endfunction

function! FormatAll()
  if &ft =~ 'javascript'
    execute ":!tmux send -t 2 C-c"
    execute ":!tmux send -t 2 'formatjs' Enter"
  elseif &ft =~ 'vue'
    execute ":!tmux send -t 2 C-c"
    execute ":!tmux send -t 2 'formatjs' Enter"
  elseif &ft =~ 'elixir'
    execute ":!tmux send -t 2 C-c"
    execute ":!tmux send -t 2 'mix format' Enter"
  endif
endfunction


" Restore cursor position, window position, and last search after running a command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

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

"Make files depend on \t tabs so don't expand them
autocmd FileType make set noexpandtab


"Commenting macro @c
let @c='0i#j'
let @v='^v0xV=j'
autocmd FileType javascript let @c='0i//j'
autocmd FileType c++ let @c='0i//j'
autocmd FileType elixir let @c='I#j'

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <C-f>F :FZF ~<cr>

" Open files in horizontal split
nnoremap <silent> <Leader>sf :call fzf#run({ 'down': '40%', 'sink': 'belowright split' })<CR>

let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* R
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

command! -bang -nargs=* SR
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview({'down':'40%', 'sink': 'belowright split'}))

command! Gs :Git | :resize 15 | :set winfixheight
nnoremap <leader>g :Gs<cr>
command! Gd :Gdiff
command! GD :Gdiff
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>d :Gdiff<cr>
nnoremap <leader>gs :Gs<cr>
nnoremap <leader>s :Gs<cr>

" Set vimdiff to ignore whitespace
set diffopt+=iwhite


" Go stuff
command! GOC :GoCoverageToggle
command! GOD :GoDiagnostics!

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

set t_ut=

command! JSON :%!jq

" golang

" filetype plugin indent on

" set autowrite

" Go syntax highlighting
let g:go_highlight_fields = 0
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0

" Auto formatting and importing
let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"

" Status line types/signatures
" let g:go_auto_type_info = 0

" Map keys for most used commands.
" autocmd FileType go nmap <leader>t  <Plug>(go-test)

"au filetype go inoremap <buffer> . .<C-x><C-o>

" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'


"source ~/.vimrc.autocomplete
source ~/.vimrc.local
