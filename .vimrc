" <Tab> as autocomplete
	" the following will map <Tab> to either actually insert a <Tab> if
	" the current line is currently only whitespace, or start/continue a CTRL-N
	" completion operation:
	" function! CleverTab()
	"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
	"       return "\<Tab>"
	"    else
	"       return "\<C-p>"
	"    endif
	" endfunction
	" inoremap <Tab> <C-R>=CleverTab()<CR>
"-------------------------------------------------------------------------------

" <Tab> as autocomplete extended
" function! InsertTabWrapper(direction)
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     elseif "backward" == a:direction
"         return "\<c-p>"
"     else
"         return "\<c-n>"
"     endif
"  endfunction
" inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
" inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
"-------------------------------------------------------------------------------

" setting for SuperTab plugin
	let g:SuperTabDefaultCompletionType = "context"
"-------------------------------------------------------------------------------

" Popup menu colors
	highlight Pmenu			  ctermbg=NONE ctermfg=NONE
	highlight Pmenu          ctermbg=NONE ctermfg=NONE cterm=NONE
	highlight PmenuSel       ctermfg=57 ctermbg=NONE cterm=bold
	" call s:hibg("Pmenu"     ,"#003366","Blue",18)
	" call s:hibg("PmenuSel"  ,"#ddff00","DarkCyan",39)
	highlight PmenuSbar       ctermbg=NONE ctermfg=NONE
	highlight PmenuThumb      ctermbg=NONE ctermfg=NONE
"-------------------------------------------------------------------------------

" Enable omni completion.
	filetype plugin on
	" autocmd FileType markdown setlocal omnifunc=htmlcomplete#ComplteTags
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	" autocmd FileType c setlocal omnifunc=ccomplete#Complete
	autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete
	autocmd FileType markdown,html,xhtml setlocal omnifunc=ccomplete#CompleteTags
"-------------------------------------------------------------------------------

" Keybindings for <F#>
"   <F2> switch paste/nopaste
	nnoremap <F2> :set invpaste paste?<CR>
	set pastetoggle=<F2>
"	<F5> switch tabs from right to left, in order, displaying the files open in them
"	     позволяет переключать вкладки справа-налево, по-порядку, отображая открытые в них файлы.
    imap <F5> <Esc> :tabprev <CR>i
    map <F5> :tabprev <CR>
"	<F6> switch tabs from left to right, in order, displaying the files open in them
"	     позволяет переключать вкладки слева-направо, по-порядку, отображая открытые в них файлы.
    imap <F6> <Esc> :tabnext <CR>i
    map <F6> :tabnext <CR>
"	<F3> clear highlighting of the last found expression
"        очистить подсветку последнего найденного выражения
    nmap <F3> :nohlsearch<CR>
    imap <F3> <Esc>:nohlsearch<CR>
    vmap <F3> <Esc>:nohlsearch<CR>gv
" 	<F4> switch wrap/nowrap
    nnoremap <F4> :set invwrap wrap?<CR>
" 	<F7> compilation *.c
    nmap <F7> :w<CR>:!gcc % && ./a.out<CR>
"     imap <F7> <Esc>:w<CR>:!gcc % && ./a.out<CR>
"     vmap <F7> <Esc>:w<CR>:!gcc % && ./a.out<CR>
"	<F8> compilation *.cpp
    nmap <F8> :w<CR>:!g++ % && ./a.out<CR>
"     imap <F8> <Esc>:w<CR>:!g++ % && ./a.out<CR>
"     vmap <F8> <Esc>:w<CR>:!g++ % && ./a.out<CR>
"-------------------------------------------------------------------------------

" autoclosing brackets
"     required set nopaste
"     replaced by plugin AutoClose
"     set nopaste " <F2>
"     inoremap " ""<left>
"     inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
"     inoremap ' ''<left>
"     inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
"     inoremap ( ()<left>
"     inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"     inoremap [ []<left>
"     inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"     inoremap { {}<left>
"     inoremap {<CR> {<CR>}<ESC>O
"     inoremap {;<CR> {<CR>};<ESC>O
"--------------------------------------------------------------------------------

" settings netrw (as NERDTree)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 50
" augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
" augroup END
"-------------------------------------------------------------------------------

" Backup and Protect
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory=~/.vim/swap//
" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.2.343")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir=~/.vim/backup//
end
" persist the undo tree for each file
set undofile
set undodir=~/.vim/undo//
"-------------------------------------------------------------------------------

" setting statusline
" use 2 lines for the status bar
set laststatus=2
" set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
if has('statusline')
	set statusline=
	set statusline+=\ %f\                 " filename
	set statusline+=%y\                 " type of file
	set statusline+=%r                  " read-only flag
	set statusline+=%m                  " modified flag
	set statusline+=\ [%{&ff}]          " file type - unix/win e.t.c.
	set statusline+=\ [%{&fenc}]\         " file encoding
" fileset statusline+=%{SyntaxItem()}\    " syntax item
" syntaxif filereadable(vimfiles_dir.'bundle/vim-git-branch-info/plugin/git-branch-info.vim')
" branchset statusline+=%=%{GitBranchInfoString()}\ " git branch name
" branchendif
" nameset statusline+=%12(0x%02B\ (%b)%)  " byte under cursor, hex+decimal
	set statusline+=%=
	set statusline+=%16(%l/%L,\ %c%)    " line number + column/virtual column
	set statusline+=\ %P                " percentage
	set statusline+=\ char=%03b                " value of character
	set statusline+=\ [%{&hlsearch?'hls':'nohls'}]
	set statusline+=\ [%{&paste?'paste':'nopaste'}]
	set statusline+=\ [%{&wrap?'wrap':'nowrap'}]
	if has('gui_running')
		set statusline+=\ %{strftime(\"%H:%M:%S\")}
	elseif $TERM != 'screen' && $TERM != 'screen-256color'
		set statusline+=\ %{strftime(\"%H:%M\")}
	endif
endif
" Сделать строку команд высотой в две строки
" set ch=2
"-------------------------------------------------------------------------------

" ctags:
" sudo ctags -R --c-kinds=+p --fields=+iaS
" set tags+=/usr/include/tags
" Ctrl+] - go to definition
" Ctrl+T - Jump back from the definition.
" Ctrl+W Ctrl+] - Open the definition in a horizontal split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>
"
" Ctrl+\ - Open the definition in a new tab
" Alt+] - Open the definition in a vertical split
" Ctrl+Left MouseClick - Go to definition
" Ctrl+Right MouseClick - Jump back from definition
" :ts <tag> <RET> " Search for a particular tag
" :tagn " Go to the next definition for the last tag
" :tp " Go to the previous definition for the last tag
" :ts " List all of the definitions of	the last tag
"-------------------------------------------------------------------------------

" Highlight N-column in files
" *.py
autocmd FileType python setlocal colorcolumn=120
autocmd FileType python set nowrap
" *.c, *.cpp
autocmd FileType c,cpp setlocal cursorline colorcolumn=81
highlight colorcolumn cterm=NONE ctermbg=236
autocmd FileType c,cpp set nowrap
" при переходе за границу в 120 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
	autocmd!
	autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType ruby,python,javascript,c,cpp match Excess /%120.*/
	autocmd FileType ruby,python,javascript,c,cpp,html,css set nowrap
augroup END
"-------------------------------------------------------------------------------

" Editor settings
" Отключаем детей Уганды
set shortmess+=I"
" enable syntax hightlight and completion
syntax on
" Number width left of this text, smaller is more compact.
set numberwidth=1
" eggcache vim
" nnoremap ; :
" :command W w
" :command WQ wq
" :command Wq wq
" :command Q q
" :command Qa qa
" :command QA qa
" Look for the file in the current directory, then south until you reach home.
" set tags=tags;~/
" % matches on if/else, html tags, etc.
" runtime macros/matchit.vim
" search
set incsearch
" set highlight highlight     " conflict with highlight current line
set ignorecase
set smartcase
set hlsearch                  " highlight search
" подсвечивает все слова, которые совпадают со словом под курсором.
" autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", "expand('<cword>'))
" Undo, history
set undolevels=1000           " размер истории для отмены
set history=1000
set confirm                   " prompt when existing from an unsaved file
" Mouse
set mouse=a                   " use mouse in all modes
set mousehide                 " Спрятать курсор мыши когда набираем текст
set t_Co=256                  " Explicitly tell vim that the terminal has 256 colors "
set report=0                  " always report number of lines changed                "
" set wrapmargin=8            "8-символьный буфер до конца терминала и делает экран более четким
" Minimal number of screen lines to keep above and below the cursor.
" This keeps the cursor always in the vertical middle of the screen.
set scrolloff=5        " The number of screen lines to keep above and below the cursor.
set sidescrolloff=5     " The number of screen columns to keep to the left and right of the cursor.
" Don't break up long lines, but visually wrap them.
set textwidth=0
set wrap                                                          " dont wrap lines - set nowrap
" set breakindentopt=shift:4
set formatoptions+=j " Delete comment characters when joining lines.
" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,cp1251,latin1,koi8-r,cp866
" Vim colorscheme customizations
" highlight Folded	ctermbg=239
" highlight IncSearch  ctermfg=197 ctermbg=none
" highlight Search     ctermfg=126 ctermbg=none
" highlight CursorLine ctermbg=255
" highlight Visual     ctermbg=45
" highlight clear cursorline
set cursorline
highlight cursorline cterm=NONE ctermbg=236
highlight cursorlineNr cterm=NONE
highlight statusline cterm=NONE ctermbg=233
" ctermbg=inverse
" ctermfg=009
set cursorcolumn
highlight CursorColumn cterm=NONE ctermbg=236
" highlight cursorcolumn cterm=NONE ctermbg=grey
" курсор при перемещении скачет по ухабам удалённых пробельных символов
" set virtualedit=all
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" По умолчанию, при нажатии ← в начале строки или → в конце, курсор не переводится на следующую/предыдущую строку.
" Это исправляет:
set whichwrap=b,s,<,>,[,]
" замена одного слова другим :%s/\<идиот\>/модератор/g
" Show line number, cursor position.
set ruler
" Display incomplete commands.
set showcmd
" Bash-like filename completion
" Show autocomplete menus
set wildmenu
" To have the completion behave similarly to a shell
set wildmode=longest:list
set wildignore=*.o,*.fasl
" Performance Options
" set complete-=i " Limit the files searched for auto-completes.
" set lazyredraw: " Don’t update screen during macro and script execution.
" Text Rendering Options
" set display+=lastlinei " Always try to show a paragraph’s last line.
set linebreak          " Avoid wrapping a line in the middle of a word.
" 	syntax enable: Enable syntax highlighting.
" 	set wrap: Enable line wrapping.
" Show editing mode
" set showmode
" Make /g flag default when doing :s
" set gdefault
" set confirm
" set ttyfast
" set title
" Clipboard OS
" во избежание лишней путаницы использовать системный буфер обмена вместо буфера Vim
" set clipboard=unnamedplus
" set virtualedit=all " позволяет курсору выходить за пределы строки
" Automatically read files which have been changed outside of Vim, if we haven't changed it already.
set autoread                    " check if file not changed by another editor
set number                      " show line numbers
" 	set relativenumber            " show relativenumber
set showmatch                   " show matching bracket (briefly jump)
set showcmd                     " show typed command in status bar
" 	set title                      " show file in titlebar
" 	Bracket blinking
set matchtime=5             " show matching bracket for 0.5 seconds
" Split new window below current one
" 	set splitbelow
" Split new window right current one
set splitright
" 	set scrolljump=-50
"-------------------------------------------------------------------------------

" CursorMoved
"     Следующие элементы будут автоматически перемещать вертикальный центральный курсор,
"     когда он находится в последней 1/3 буфера при вводе любого символа
"     или переходе в режим вставки в этой области
"     augroup autoCenter
"       autocmd!
"       autocmd InsertCharPre,InsertEnter * if (winline() * 3 >= (winheight(0) * 2))
"                                                 \| norm! zz
"                                             \| endif
"     augroup END
"-------------------------------------------------------------------------------

" CursorMoved
autocmd CursorMoved
  \ if line('.') > line('w$') - &scrolloff
  \ && line('w0') + winheight(0) - 1 - &scrolloff < line('w$')
  \ | exec 'normal ^R'
  \ | endif
" 	autocmd CursorMoved * if line('.') == line('$') | call append('5$', '') | endif
"-------------------------------------------------------------------------------

" Default Indentation
" set autoindent
set expandtab       " expand tab to space
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
" set textwidth=79
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set cindent
"set cinkeys
"set cinoptions=s,fs,{0
"set cinwords
"set indentexpr
"-------------------------------------------------------------------------------

" Ctrl+c, Ctrl+x only visual and insert mode
vnoremap <C-c> "+y
vmap <C-x> "+c
" Ctrl+v
" vmap <C-v> c<ESC>p
" imap <C-v> <C-r><C-o>+
"-------------------------------------------------------------------------------

"удаление лишних пробелов
" autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" autocmd BufWritePre * :%s/\s\+$//e
"-------------------------------------------------------------------------------

" Remove whitespaces from all file
function! TrimWhitespace()
	%s/\s+$//e
endfunction
command! TrimWhitespace call TrimWhitespace()
"-------------------------------------------------------------------------------

" Folding setting
" zc - свернуть блок
" zo - развернуть блок
" zM - закрыть все блоки
" zR - открыть все блоки
" za - инвертирование
" zf - см :set foldmethod=manual
" zj - переход к следующей свертке
" zk - переход к предыдущей свертке
" zd - удалить свертку под курсором
" zD - удалить все свертки
" [z - перейти к началу текущей свертки
" ]z - перейти к концу текущей свертки
set foldenable           	"включить свoрачивание
" set foldmethod=syntax     "сворачивание на основе синтаксиса
" set foldmethod=indent    	"сворачивание на основе отступов
set foldmethod=manual   	" выделяем участок с помощью v и говорим zf
set foldmethod=expr  		" на основе выражения
" :set foldmethod=marker    "сворачивание на основе маркеров в тексте
" :set foldmarker=begin,end задаем маркеры начала и конца блока
" This will make a fold out of paragraphs separated by blank lines: >
set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" This does the same: >
" 	:set foldexpr=getline(v:lnum-1)=~'^\\s*$'&&getline(v:lnum)=~'\\S'?'>1':1
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
"-------------------------------------------------------------------------------

" View non-text files in Vim
" 	:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
    au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78
    au BufReadPost *.doc silent %!antiword "%"
    au BufReadPost *.odt silent %!odt2txt "%"
"-------------------------------------------------------------------------------

" Setting syntastic
" 	shows errors and warnings in the status bar (together with scrooloose / syntastic)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" 	let g:syntastic_cpp_checkers=["cpp"]
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
"-------------------------------------------------------------------------------

" FileType autocmd
if has("autocmd")
	"Включаем определение типов файлов
	filetype on
	autocmd FileType php setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType python setlocal ts=4 sts=4 sw=4 et
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType html setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType xml setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType css setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType vim setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
	autocmd BufNewFile,BufRead *.tmpl,*.tpl setfiletype html
endif
"-------------------------------------------------------------------------------

" Commenting blocks of code.
"     Use ,cc - comment, ,cu - uncomment(normal and visual modes)
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python let b:comment_leader = '# '
autocmd FileType conf,fstab let b:comment_leader = '# '
autocmd FileType tex let b:comment_leader = '% '
autocmd FileType mail let b:comment_leader = '> '
autocmd FileType vim let b:comment_leader = '" '
autocmd FileType vifm let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
"-------------------------------------------------------------------------------

" Say a message
" 	function! Say(msg)
" 		echohl IncSearch
" 		echo a:msg
" 		echohl None
" 	endfunction
" Copy full buffer to OS clipboard.
" 	function! CopyAll()
" 		normal mzggVG"+y'z
" 		call Say("Copied.")
" 	endfunction
" 	command A call CopyAll()"
" Delete buffer contents and Paste from OS clipboard.
" 	function! PasteFromClipboard()
" 		normal ggVGd"+p1G
" 		call Say("Pasted.")
" 	endfunction
" 	command B call PasteFromClipboard()
"-------------------------------------------------------------------------------

" Quick choice of encoding:
	menu Encoding.windows-1251 :e ++enc=cp1251 ++ff=dos<CR>
	menu Encoding.cp866 :e ++enc=cp866 ++ff=dos<CR>
	menu Encoding.utf-8 :e ++enc=utf8<CR>
	menu Encoding.koi8-u :e ++enc=koi8-u ++ff=unix<CR>
	menu Encoding.koi8-r :e ++enc=koi8-r ++ff=unix<CR>
	menu Encoding.latin1 :e ++enc=latin1 ++ff=unix<CR>
" <F9> + <TAB>
	nmap <F9> :emenu Encoding.
"-------------------------------------------------------------------------------

" Expandtab
" С/C++ файлы
autocmd filetype c,cpp set cin
" make-файлы
" В make-файлах нам не нужно заменять табуляцию пробелами
autocmd filetype make set noexpandtab
autocmd filetype Makefile set noexpandtab
" autocmd filetype Makefile.am set noexpandtab
autocmd filetype make set nocin
" html-файлы
" Не расставлять отступы в стиле С в html файлах
autocmd filetype html set noexpandtab
autocmd filetype html set nocin
autocmd filetype html set textwidth=160
" css-файлы
" Не расставлять отступы в стиле C и не заменять табуляцию пробелами
autocmd filetype css set nocin
autocmd filetype css set noexpandtab
" python-файлы
" Не расставлять отступы в стиле С
autocmd filetype python set nocin
" sh по <Ctrl+d>, так же возвращение в vim.
noremap <C-d> :!/bin/bash<CR>
"-------------------------------------------------------------------------------

" Python, подсвечивать всё.
	let python_highlight_all = 1
"-------------------------------------------------------------------------------

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif
" 	if has("autocmd")
"
" 	if has("autocmd")
" 		set viewoptions=cursor,folds
" 		au BufWinLeave * mkview
" 		au BufWinEnter * silent loadview
" 	endif
"-------------------------------------------------------------------------------

" w!! to sudo & write a file
	cmap w!! %!sudo tee >/dev/null %
"-------------------------------------------------------------------------------

" Quickly edit/reload the vimrc file
"   :so $MYVIMRC<CR>
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>
"-------------------------------------------------------------------------------

