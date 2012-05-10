"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"https://gist.github.com/860397
" This must be first, because it changes other options as a side effect.
set nocompatible

set backup		" keep a backup file
if isdirectory($HOME . "/.vim/backup") " but don't bloat unnecessarily
	set backupdir=$HOME/.vim/backup//
endif
set history=50		" keep 50 lines of command line history

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78
  " autocmd FileType tex setlocal textwidth=78
  " Better latex editing
  " autocmd BufNewFile,BufRead *.tex setlocal wrap
  " autocmd BufNewFile,BufRead *.tex setlocal linebreak


  autocmd! bufwritepost .vimrc source % " Apply settings on write 
  cmap w!! w !sudo tee % >/dev/null
  " autocmd BufEnter * lcd %:p:h " Use directory of file as current directory

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Remaps {
	let mapleader = ","
	if has('mouse')
		set mouse=a
	endif
	" Don't use Ex mode, use Q for formatting
	map Q gq

	" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
	" so that you can undo CTRL-U after inserting a line break.
	inoremap <C-U> <C-G>u<C-U>

	" Move by screen lines
	nnoremap gj j 
	nnoremap gk k 
	nnoremap j gj
	nnoremap k gk
	set backspace=indent,eol,start " allow backspacing over everything in insert mode
	" Smart way to move between windows
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

	" Select all
	map <leader>a ggVG
	" Copy all
	nmap <leader>y gg"+yG 
	" Easier copy/paste to global clipboard
 	map <c-y> "+y
	map <c-p> "+p

	cmap W w
	" save and compile latex document
	" map <leader>p :w \| lcd %:p:h \| !pdflatex "%"<CR>
	map <leader>p :w \| :make<CR>
	"Open file without extension
	map <leader>r :!%:p:h/%:t:r<CR> " Ser inte output
	map <leader>R :!%:p:h/%:t:r
	map <leader>t :!time :!%:p:h/%:t:r<CR>
	" Change dir to current file location
	map <leader>cd :cd %:p:h<CR>:pwd<CR>
	"" Easier spellchecking
	" nmap <right> ]s
	" nmap <left> [s
	" nmap <down> z=
	" nmap <up><up> zg
	noremap <c-left> :bprev<CR>
	noremap <c-right> :bnext<CR> 
	map <leader>v :split $MYVIMRC<CR>
	" map <leader>c :w \| !gcc -pedantic -std=c99 -o %< %<CR>
	" map <leader>r !echo %<
" }
" Plugins {
	call pathogen#runtime_append_all_bundles()
	" call pathogen#helptags()
	"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
	"let g:SuperTabContextDefaultCompletionType = "<C-X><C-O>"
	"let g:miniBufExplMapCTabSwitchBufs = 1
	map <leader>n :NERDTreeToggle<CR>
	let g:vimwiki_use_mouse = 1
" }

" UI {
	" Switch syntax highlighting on, when the terminal has colors
	" Also switch on highlighting the last used search pattern.
	if &t_Co > 2 || has("gui_running")
		syntax on
		set hlsearch
		if has('win32') 
			set gfn=Inconsolata:h13:cANSI
		else 
			set gfn=Inconsolata\ Medium\ 13
		endif
			" set guioptions-=m  "remove menu bar
		set guioptions-=T  "remove toolbar
	endif
	set background=dark
	colorscheme solarized

	function! ToggleBackground()
		if (g:solarized_style=="dark")
		let g:solarized_style="light"
		colorscheme solarized
	else
		let g:solarized_style="dark"
		colorscheme solarized
	endif
	endfunction
	command! Togbg call ToggleBackground()

	set diffopt+=iwhite
	set tabstop=4
	set shiftwidth=4

	" set rnu
	set showmode
	set ruler		" show the cursor position all the time
	set showcmd		" display incomplete commands
	set scrolloff=3         " minimum lines to keep above and below cursor
	set wildmenu 		" Fancier commandline tab completion
	set statusline=%n%<\ %f\ %m%r%w\ %{fugitive#statusline()}%=%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%Y\ %4c\ \|\ %4l\ 
	set laststatus=2
" }
" Searching {
	set ignorecase                  " case insensitive search
	set smartcase                   " case sensitive when uc present
	set incsearch			" do incremental searching
	set gdefault                    " the /g flag on :s substitutions by default
	" clear search highlight
	nmap <silent> <C-N> :silent noh<CR>
" }
"
"
" Command reference
" =================
"
" :split $MYVIMRC	Open in split
" ;	Repeat last f command.
" * 	Read the string under the cursor and go to the next place it appears.
" gq	Reformat text (textwidth)
" gi	Go to where you last edited
" +p	Paste from system clipboard
" 
"
" In editmode
" 
" <C-R>=	Insert calculated answer
"
" Command mode
" ============
"
" :lvim searchterm files
" :lw	To show list
"
" * - seach in current dir 
" ** - search recursively

" :setf php - set syntax highlight to php
