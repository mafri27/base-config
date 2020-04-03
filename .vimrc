" =========================
"   General
" =========================
"

set sw=4
set mouse=a





" ===========================
" TAB completition
" ===========================

" smart mapping for tab completion
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>







" Extra terminal things
if (($TERM == "rxvt-unicode") || ($TERM =~ "xterm") || ($TERM =~ "screen")) && (&termencoding == "")
    set termencoding=utf-8
endif
"
"     compatible:  Let Vim behave like Vi?  Hell, no!
set nocompatible


" =========================
"   Files/Backups
" =========================
"
"       backup:  backups are for wimps  ;-)
set   nobackup
"
" Enable a nice big viminfo file
set   viminfo='1000,f1,:1000,/1000
"
"       autowrite: Automatically save modifications to files
"       when you use critical (rxternal) commands.
set   autowrite


" =========================
"   Colors
" =========================
"
" Try to load a nice colourscheme
fun! LoadColourScheme(schemes)
    let l:schemes = a:schemes . ":"
    while l:schemes != ""
        let l:scheme = strpart(l:schemes, 0, stridx(l:schemes, ":"))
        let l:schemes = strpart(l:schemes, stridx(l:schemes, ":") + 1)
        try
            exec "colorscheme" l:scheme
            break
        catch
        endtry
    endwhile
endfun

if has('gui')
    call LoadColourScheme("inkpot:night:rainbow_night:darkblue:elflord")
else
    if &t_Co == 88 || &t_Co == 256
        call LoadColourScheme("inkpot:desert256:darkblack:darkblue:elflord")
    else
        "       call LoadColourScheme("desert256:darkblack:desert:darkblue:elflord")
        "       Colorize some default highlight groups
        "       see ":help highlight-default"
        "
        "            Comments: Colorizing the "comments" (see ":help comments").
        "            cyan on white does not look good on a black background..
        hi comment                           ctermfg=cyan   ctermbg=black
        "         hi comment                           ctermfg=cyan   ctermbg=7
        "
        "       hi Cursor
        "       hi Directory
        "       hi ErrorMsg
        "       hi FoldColumn
        "       hi Folded
        "       hi IncSearch
        "
        "            LineNr:  Colorize the line numbers (displayed with
        "            "set number").
        "            Turn off default underlining of line numbers:
        hi LineNr term=NONE cterm=NONE ctermfg=grey ctermbg=black
        "
        "       hi ModeMsg
        "       hi MoreMsg
        "
        "         coloring "nontext", ie TABs, trailing spaces,  end-of-lines,
        "         and the "tilde lines" representing lines after end-of-buffer.
        hi NonText term=NONE cterm=NONE ctermfg=blue   ctermbg=black
        "
        "            Normal text:    Use white on black.
        "         hi normal ctermfg=white ctermbg=black guifg=white guibg=black
        hi normal ctermfg=grey  ctermbg=black guifg=grey guibg=black
        "       Oops - this overrides the colors for the status line - DANG!
        "
        "       hi Question
        "
        "            Search: Coloring "search matches".  Use white on red.
        hi search  ctermfg=white ctermbg=red     guifg=white guibg=red
        "
        "         hi SpecialKey
        "
        "            statusline: coloring the status line -> is not possible :-(
        "         hi StatusLine  term=NONE cterm=NONE ctermfg=yellow ctermbg=red
        "
        "         hi Title
        "         hi VertSplit
        "         hi Visual
        "         hi VisualNOS
        "         hi WarningMsg
        "         hi WildMenu
        "
        "         Other Groups:
        "
        "            Normal:  Coloring the text with a default color.
        hi normal       term=NONE
    endif
endif

" =========================
"   Vim UI
" =========================
"
"       backspace:  '2' allows backspacing" over
"       indentation, end-of-line, and start-of-line.
"       see also "help bs".
set   backspace=2

"       ruler:       show cursor position?  Yep!
set   ruler
"
"       shortmess:   Kind of messages to show.   Abbreviate them
"       all!  New since vim-5.0v: flag 'I' to suppress "intro
"       message".
set   shortmess=at
"
"       showcmd:     Show current uncompleted command?
"       Absolutely!
set   showcmd

"       showfulltag: (sft) auto completion (great for programming)
" set   showfulltag
"
"       showmode:    Show the current mode?
"       YEEEEEEEEESSSSSSSSSSS!
set   showmode
"
"       splitbelow:  Create new window below current one.
set   splitbelow
"
"       Highlight matching parens

set   showmatch
"
" Try to show at least three lines and two columns of context when
" scrolling
set   scrolloff=3
set   sidescrolloff=2
"
"       mouse: enable mouse scrolling, mouse selection etc.
" set mouse=a
"
"       modeline:  Allow the last line to be a modeline - useful
"       when the last line in sig gives the preferred textwidth
"       for replies.
if (v:version == 603 && has("patch045")) || (v:version > 603)
    set   modeline
    set   modelines=1
else
    set   nomodeline
endif
"
"       foldenable: When off, all folds are open.
set   nofoldenable
"
" Nice statusbar
set   laststatus=2
set   statusline=
set   statusline+=%-3.3n\                      " buffer number
set   statusline+=%f\                          " file name
set   statusline+=%h%m%r%w                     " flags
set   statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set   statusline+=%{&encoding},                " encoding
set   statusline+=%{&fileformat}]              " file format

if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set   statusline+=\ %{VimBuddy()}          " vim buddy
endif
set   statusline+=%=                           " right align
set   statusline+=0x%-8B\                      " current char
set   statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" If possible, try to use a narrow number column.
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif


" =========================
"   Visual Cues
" =========================
"
"       errorbells: damn this beep!  ;-)
"       "vi has two modes - one in which it beeps
"       and another in which it doesn't."
set   noerrorbells
"
"       hlsearch :  highlight search - show the current search pattern
"       This is a nice feature sometimes - but it sure can get in the
"       way sometimes when you edit.
set   hlsearch
"
"       incsearch: While typing a search command, show immediately where
"       the so far typed pattern matches.  The matched string is
"       highlighted.
set   incsearch
"
" set   infercase
"
"       icon:       i do not need no steekeen icon title string.
set   noicon
"
"       visualbell:
set   visualbell
"
"       showmatch:   Show the matching bracket for the last ')'?
set   showmatch
"
"       mat: how many tenths of a second to blink matching
"       brackets
set   mat=5
"
"       Speed up macros
set   lazyredraw
"
"       Use the cool tab complete menu
set   wildmenu
set   wildmode=list:longest,full
set   wildignore=*.o,*~

" =========================
"   Text Formatting/Layout
" =========================
"
"       autoindent: auto indent, nice for coding
set   autoindent
"
"       smartindent: Do smart autoindenting when starting a new line.
"       Works for C-like programs, but can also be used for other
"       languages. cindent or smartindent
" set   smartindent
"
"       cindent: do c-style indenting
set   cindent
"
"       shiftwidth: Number of spaces to use for each insertion of
"       (auto)indent.
set   shiftwidth=4
"
"       tabstop: (ts)
set   tabstop=8
"
"       smarttab: Use tabs at the start of a line, spaces elsewhere
set   smarttab
"
"       textwidth: (tw)
" set   textwidth=79
"
"       expandtab:  Expand Tabs?  Rather not.
"                   See 'listchars' to make Tabs visible!
set   noexpandtab
"
"       comments default: sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
" set   comments=b:#,:%,fb:-,n:>,n:)
" This command is for nice comments in C :)
" set   comments=sr:/*,mb:\ *,el:*/,://,b:#,:%,:XCOMM,n:>,n:),fb:-
"
"       formatoptions:  Options for the "text format" command ("gq")
"                       I need all those options (but 'o')!
" set   formatoptions=cqrt
set   formatoptions=tcrqn
"
"       joinspaces:
"       insert two spaces after a period with every joining of lines.
"       I like this as it makes reading texts easier (for me, at least).
set   joinspaces
"
"       whichwrap: Allow jump commands for left/right motion to
"       wrap to previous/next line when cursor is on first/last
"       character in the line:
set   whichwrap+=<,>,[,]
"
set   linebreak
set   wrap
"
" Allow edit buffers to be hidden
set   hidden
"
" 1 height windows
set winminheight=1
"
" Enable syntax highlighting
syntax on
"
" No icky toolbar, menu or scrollbars in the GUI
if has('gui')
    set guioptions+=m
    set guioptions+=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
end

inoremap # X<BS>#

" Enable folds
"set foldenable
"set foldmethod=indent
"set foldlevel=1
"set foldcolumn=1

" Syntax when printing
set popt+=syntax:y

" Enable filetype settings
filetype on
filetype plugin on
filetype indent on

"
" Include $HOME in cdpath
let &cdpath=','.expand("$HOME")

" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        "        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
        "        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif

set fillchars=fold:-


" ==============
"   Completion
" ==============
set dictionary=/usr/share/dict/words


" ============
"   Autocmds
" ============

" If we're in a wide window, enable line numbers.
fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal number
    else
        setlocal nonumber
    endif
endfun

" Force active window to the top of the screen without losing its
" size.
fun! <SID>WindowToTop()
    let l:h=winheight(0)
    wincmd K
    execute "resize" l:h
endfun

" Force active window to the bottom of the screen without losing its
" size.
fun! <SID>WindowToBottom()
    let l:h=winheight(0)
    wincmd J
    execute "resize" l:h
endfun

" Update .*rc header
fun! <SID>UpdateRcHeader()
    let l:c=col(".")
    let l:l=line(".")
    1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%a %b %d %T %Z %Y")-
    call cursor(l:l, l:c)
endfun

" My autocmds
augroup cynapses
    autocmd!

    " Turn off search highlight when idle
    autocmd CursorHold * nohls | redraw

    " Automagic line numbers
    autocmd BufEnter * :call <SID>WindowWidth()

    " Update header in .vimrc and .bashrc before saving
    autocmd BufWritePre *vimrc.forall :call <SID>UpdateRcHeader()
    autocmd BufWritePre *vimrc.mine :call <SID>UpdateRcHeader()
    autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
    autocmd BufWritePre *screenrc :call <SID>UpdateRcHeader()
    autocmd BufWritePre *bashrc :call <SID>UpdateRcHeader()
    autocmd BufWritePre *openalrc :call <SID>UpdateRcHeader()

    " Always do a full syntax refresh
    autocmd BufEnter * syntax sync fromstart

    " For help files, move them to the top window and make <Return>
    " behave like <C-]> (jump to tag)
    autocmd FileType help :call <SID>WindowToTop()
    autocmd FileType help nmap <buffer> <Return> <C-]>

    " For the quickfix window, move it to the bottom
    autocmd FileType qf :3 wincmd _ | :call <SID>WindowToBottom()

    " For svn-commit, don't create backups
    autocmd BufRead svn-commit.tmp :setlocal nobackup
    au BufNewFile,BufRead  svn-commit.* setf svn

    " suse changes files
    autocmd BufRead /tmp/vc.* :setlocal ft=changes

    " subdomain config siles
    autocmd BufRead /etc/subdomain.d/* :setlocal ft=subdomain

    " drupal modules
    autocmd BufRead */modules/*/*.module :setlocal ft=php

    " Detect procmailrc
    autocmd BufRead procmailrc :setfiletype procmail

    " Detect SCons files
    autocmd BufRead SConscript* :setfiletype python
    autocmd BufRead SConstruct* :setfiletype python

    " CMake Files
    autocmd BufRead CMakeLists.txt :setlocal et ts=2 sw=2 comments=\:\#
    autocmd BufRead *.cmake :setlocal et ts=2 sw=2 comments=\:\#

    " bash-completion ftdetects
    autocmd BufNewFile,BufRead /*/*bash*completion*/*
                \ if expand("<amatch>") !~# "ChangeLog" |
                \     let b:is_bash = 1 | set filetype=sh |
                \ endif

    " fix background color bug in screen
    if ($TERM =~ "screen")
        autocmd VimLeave * :set term=screen
    endif

    try
        " if we have a vim which supports QuickFixCmdPost (patch by
        " ciaranm, marked for inclusion in vim7), give us an error
        " window after running make, grep etc, but only if results are
        " available.
        autocmd QuickFixCmdPost * :cwindow 3
    catch
    endtry
augroup END

" ============
"   Mappings
" ============

" tab navigation
nmap T :tabnew<CR>
map  T :tabnew<CR>

nmap W :tabclose<CR>
map  W :tabclose<CR>

nmap X :tabnext<CR>
map  X :tabnext<CR>

nmap Y :tabprevious<CR>
map  Y :tabprevious<CR>

nmap   <silent> <S-Right>  :bnext<CR>

" Delete a buffer but keep layout
command! Kwbd enew|bw #
nmap     <C-w>!   :Kwbd<CR>

" Make <space> in normal mode go down a page rather than left a
" character

" Commonly used commands
nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>
nmap <F5> <C-w>c
nmap <F4> :Kwbd<CR>
nmap <F7> :so %<CR>
nmap <F8> :make<CR>
nmap <F12> :pop<CR>

" Insert a single char
noremap <Leader>i i<Space><Esc>r

" Split the line
nmap <Leader>n \i<CR>

" Pull the following line to the cursor position
noremap <Leader>J :s/\%#\(.*\)\n\(.*\)/\2\1<CR>

" In normal mode, jj escapes
inoremap jj <Esc>

" Select everything
noremap <Leader>gg ggVG

" Reformat everything
noremap <Leader>gq gggqG

" Reformat paragraph
noremap <Leader>gp gqap

" Clear lines
noremap <Leader>clr :s/^.*$//<CR>:nohls<CR>

" Delete blank lines
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>

" Enclose each selected line with markers
noremap <Leader>enc :<C-w>execute
            \ substitute(":'<,'>s/^.*/#&#/ \| :nohls", "#", input(">"), "g")<CR>

" Enable fancy % matching
runtime! macros/matchit.vim

" q: sucks
nmap q: :q

" set up some more useful digraphs
digraph ., 8230    " ellipsis (…)

" command aliases, can't call these until after cmdalias.vim is loaded
au VimEnter * if exists("loaded_cmdalias") |
            \       call CmdAlias("mkdir",   "!mkdir") |
            \       call CmdAlias("cvs",     "!cvs") |
            \       call CmdAlias("svn",     "!svn") |
            \       call CmdAlias("commit",  "!svn commit -m \"") |
            \       call CmdAlias("upload",  "make upload") |
            \ endif


" ===================================================================
" ABbreviations
" ===================================================================
" 980701: Moved the abbreviations *before* the mappings as some of
" the abbreviations get used with some mappings.
"
"  Let's start of with some standard strings like the alphabet and
"  the digits:
"
"     Yalpha : The lower letter alphabet.
iab Yalpha abcdefghijklmnopqrstuvwxyz
"
"     YALPHA : The upper letter alphabet.
iab YALPHA ABCDEFGHIJKLMNOPQRSTUVWXYZ
"
"     Ydigit: The ten digits.
iab Ydigit  1234567890
"     Yhex:   The sixteen digits of a hexadecimal system.
iab Yhex    1234567890ABCDEF
"
"     Yruler: A "ruler" - nice for counting the length of words.
"     80 digits there - just perfect for a standard terminal!
iab Yruler  1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"
" Abbreviations for some important numbers:
iab Npi     3.1415926535897932384626433832795028841972
iab Neuler  2.7182818284590452353602874713526624977573


" ===================================================================
" Abbreviations - General Editing - Inserting Dates and Times
" ===================================================================
"
" First, some command to add date stamps (with and without time).
" I use these manually after a substantial change to a webpage.
" [These abbreviations are used with the mapping for ",L".]
"
iab Ydate <C-R>=strftime("%y%m%d")<CR>
" Example: 971027
"
iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 14:28
"
" man strftime:     %T      time as %H:%M:%S iab YDT
" <C-R>=strftime("%y%m%d %T")<CR> Example: 971027 12:00:00
"
" man strftime:     %X      locale's appropriate time
" representation
iab YDT           <C-R>=strftime("%y%m%d %X")<CR>
" Example: 000320 20:20:20
"
iab YDate <C-R>=strftime("%Y-%m-%d")<CR>
" Example: 2002-04-06
"
iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
" Example: Tue Dec 16 12:07:00 CET 1997

iab YSpecDate * <C-R>=strftime("%a %b %d %Y")<CR> - Andreas Schneider <andreas@links2linux.de>

" ==================================
"   Plugin / Script / App Settings
" ==================================

" Perl specific options
let perl_include_pod=1
let perl_fold=1
let perl_fold_blocks=1

" Vim specific options
let g:vimsyntax_noerror=1

" Settings minibufexpl.vim
let g:miniBufExplModSelTarget = 1
let g:miniBufExplWinFixHeight = 1

" Settings for showmarks.vim
if has("gui_running")
    let g:showmarks_enable=1
else
    let g:showmarks_enable=0
    let loaded_showmarks=1
endif

autocmd VimEnter *
            \ if has('gui') |
            \        highlight ShowMarksHLl gui=bold guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLu gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLo gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLm gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight SignColumn   gui=none guifg=#f0f0f8 guibg=#2e2e2e |
            \    endif

" Settings for explorer.vim
let g:explHideFiles='^\.'

" Settings for netrw
let g:netrw_list_hide='^\.,\~$'

" Settings for :TOhtml
let html_number_lines=1
let html_use_css=1
let use_xhtml=1

" cscope settings
if has('cscope') && filereadable("/usr/bin/cscope")
    set csto=0
    set cscopetag
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb

    let x = "sgctefd"
    while x != ""
        let y = strpart(x, 0, 1) | let x = strpart(x, 1)
        exec "nmap <C-j>" . y . " :cscope find " . y .
                    \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
        exec "nmap <C-j><C-j>" . y . " :scscope find " . y .
                    \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
    endwhile
    nmap <C-j>i      :cscope find i ^<C-R>=expand("<cword>")<CR><CR>
    nmap <C-j><C-j>i :scscope find i ^<C-R>=expand("<cword>")<CR><CR>
endif



" markdown filetype file
augroup markdown
    au! BufRead,BufNewFile *.mkd   setfiletype mkd
augroup END
" Finally, to get some nice Markdown formatting behavior, add these lines to your .vimrc: 
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

"if has("gui_running")
"    set background=dark
"endif
set background=dark
set expandtab
"
" ===================================================================
" ASCII tables - you may need them some day.  Save them to a file!
" ===================================================================
"
" 001005: In need of an ASII table?  Perl is your friend:
"         perl -e 'while($i++<256) { print chr($i); }'
"
" ASCII Table - | octal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |010 bs |011 ht |012 nl |013 vt |014 np |015 cr |016 so |017 si |
" |020 dle|021 dc1|022 dc2|023 dc3|024 dc4|025 nak|026 syn|027 etb|
" |030 can|031 em |032 sub|033 esc|034 fs |035 gs |036 rs |037 us |
" |040 sp |041  ! |042  " |043  # |044  $ |045  % |046  & |047  ' |
" |050  ( |051  ) |052  * |053  + |054  , |055  - |056  . |057  / |
" |060  0 |061  1 |062  2 |063  3 |064  4 |065  5 |066  6 |067  7 |
" |070  8 |071  9 |072  : |073  ; |074  < |075  = |076  > |077  ? |
" |100  @ |101  A |102  B |103  C |104  D |105  E |106  F |107  G |
" |110  H |111  I |112  J |113  K |114  L |115  M |116  N |117  O |
" |120  P |121  Q |122  R |123  S |124  T |125  U |126  V |127  W |
" |130  X |131  Y |132  Z |133  [ |134  \ |135  ] |136  ^ |137  _ |
" |140  ` |141  a |142  b |143  c |144  d |145  e |146  f |147  g |
" |150  h |151  i |152  j |153  k |154  l |155  m |156  n |157  o |
" |160  p |161  q |162  r |163  s |164  t |165  u |166  v |167  w |
" |170  x |171  y |172  z |173  { |174  | |175  } |176  ~ |177 del|
"
" ===================================================================
" ASCII Table - | decimal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |008 bs |009 ht |010 nl |011 vt |012 np |013 cr |014 so |015 si |
" |016 dle|017 dc1|018 dc2|019 dc3|020 dc4|021 nak|022 syn|023 etb|
" |024 can|025 em |026 sub|027 esc|028 fs |029 gs |030 rs |031 us |
" |032 sp |033  ! |034  " |035  # |036  $ |037  % |038  & |039  ' |
" |040  ( |041  ) |042  * |043  + |044  , |045  - |046  . |047  / |
" |048  0 |049  1 |050  2 |051  3 |052  4 |053  5 |054  6 |055  7 |
" |056  8 |057  9 |058  : |059  ; |060  < |061  = |062  > |063  ? |
" |064  @ |065  A |066  B |067  C |068  D |069  E |070  F |071  G |
" |072  H |073  I |074  J |075  K |076  L |077  M |078  N |079  O |
" |080  P |081  Q |082  R |083  S |084  T |085  U |086  V |087  W |
" |088  X |089  Y |090  Z |091  [ |092  \ |093  ] |094  ^ |095  _ |
" |096  ` |097  a |098  b |099  c |100  d |101  e |102  f |103  g |
" |104  h |105  i |106  j |107  k |108  l |109  m |110  n |111  o |
" |112  p |113  q |114  r |115  s |116  t |117  u |118  v |119  w |
" |120  x |121  y |122  z |123  { |124  | |125  } |126  ~ |127 del|
"
" ===================================================================
" ASCII Table - | hex value - name/char |
"
" | 00 nul| 01 soh| 02 stx| 03 etx| 04 eot| 05 enq| 06 ack| 07 bel|
" | 08 bs | 09 ht | 0a nl | 0b vt | 0c np | 0d cr | 0e so | 0f si |
" | 10 dle| 11 dc1| 12 dc2| 13 dc3| 14 dc4| 15 nak| 16 syn| 17 etb|
" | 18 can| 19 em | 1a sub| 1b esc| 1c fs | 1d gs | 1e rs | 1f us |
" | 20 sp | 21  ! | 22  " | 23  # | 24  $ | 25  % | 26  & | 27  ' |
" | 28  ( | 29  ) | 2a  * | 2b  + | 2c  , | 2d  - | 2e  . | 2f  / |
" | 30  0 | 31  1 | 32  2 | 33  3 | 34  4 | 35  5 | 36  6 | 37  7 |
" | 38  8 | 39  9 | 3a  : | 3b  ; | 3c  < | 3d  = | 3e  > | 3f  ? |
" | 40  @ | 41  A | 42  B | 43  C | 44  D | 45  E | 46  F | 47  G |
" | 48  H | 49  I | 4a  J | 4b  K | 4c  L | 4d  M | 4e  N | 4f  O |
" | 50  P | 51  Q | 52  R | 53  S | 54  T | 55  U | 56  V | 57  W |
" | 58  X | 59  Y | 5a  Z | 5b  [ | 5c  \ | 5d  ] | 5e  ^ | 5f  _ |
" | 60  ` | 61  a | 62  b | 63  c | 64  d | 65  e | 66  f | 67  g |
" | 68  h | 69  i | 6a  j | 6b  k | 6c  l | 6d  m | 6e  n | 6f  o |
" | 70  p | 71  q | 72  r | 73  s | 74  t | 75  u | 76  v | 77  w |
" | 78  x | 79  y | 7a  z | 7b  { | 7c  | | 7d  } | 7e  ~ | 7f del|
" ===================================================================

"       vim:tw=73 et sw=4 comments=\:\"
"
"

set tabstop=4
set expandtab

"format all
nmap <c-f> mtgg=G't
imap <c-f> <ESC><c-f>i

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>       "+gP
map <S-Insert>      "+gP

cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+
"move lines

nmap <c-down> ddp 
nmap <c-up> ddkP
nmap <c-left> << 
nmap <c-right> >>

"imap <c-down>  <ESC><c-down>i
"imap <c-up>    <ESC><c-up>i
"imap <c-left>  <ESC><c-left>i
"imap <c-right> <ESC><c-right>i
