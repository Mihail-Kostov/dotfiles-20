set nocompatible " behave in a more useful way

call pathogen#infect() " activate pathogen.vim

" miscellaneous
set autoread                   " read updated files
set hidden                     " allow hidden buffers
set esckeys                    " allow arrow keys in insert mode
set backspace=indent,eol,start " allow backspacing over everything

" interface
set cursorline " highlight the line containing the cursor
set number     " show line numbers
set showmode   " show mode (slows down terminal)

if has("gui_running")
    set guioptions-=T     " hide the toolbar
    set guifont=Menlo:h16 " set font name and size
    set lines=999         " make the window as tall as possible
    set ruler             " show cursor coordinates (slows down terminal)
    set showcmd           " show command in progress (slows down terminal)
endif

" scrolling
set nostartofline    " remember cursor column when scrolling
set scrolloff=8      " scroll when 8 lines from top or bottom
set sidescrolloff=15 " scroll when 15 columns from left or right
set sidescroll=1     " scroll 1 column at a time

" search
set incsearch  " search while typing
set hlsearch   " highlight all matches
set ignorecase " case-insensitive search
set smartcase  " case-sensitive if searching for uppercase

" tabs
set tabstop=8     " make tabs 8 columns wide
set softtabstop=4 " indent as if tabs are 4 columns wide
set shiftwidth=4  " indent 4 columns
set expandtab     " insert spaces instead of tabs
set autoindent    " keep indentation level on new lines
set smartindent   " guess new indentation levels

" command completion
set wildmenu " use a menu to browse command completions
set wildmode=list:longest,full " complete longest common string, then list alternatives
set wildignore=*.png,*.jpg,*.gif,.git,.svn

" swap files
set nobackup
set directory=~/.vim/swap,/tmp

" terminal
"set t_ti= t_te= " don't clear the scrollback buffer on exit

" color mode
set t_Co=256 " enable 256-color terminal support

" colors
syntax enable                  " turn on syntax highlighting
set background=dark            " use a dark background
let g:solarized_termcolors=256 " enable theme 256-color terminal support
let g:solarized_termtrans=1    " use terminal's background instead of theme's
colorscheme solarized          " set theme

" customize terminal color choices
hi LineNr ctermbg=black
hi CursorLine ctermbg=black

" filetype-specific plugins, indentation, etc.
filetype plugin indent on

augroup AutoFileType
    autocmd!
    autocmd FileType html setlocal softtabstop=2 shiftwidth=2 
    autocmd BufNewFile,BufRead *.less setlocal filetype=css
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
augroup END

" use tab for omni completion unless preceded by whitespace
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-P>"
    endif
endfunction
inoremap <Tab> <C-R>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-N>

" leader
let mapleader=","

" toggle search highlighting with ,n
nmap <silent> <Leader>n :silent :nohlsearch<CR>

" toggle trailing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <Leader>s :set nolist!<CR>

" Command-T plugin
let g:CommandTMaxFiles=2000 " don't scan more than 2000 files (for speed)
let g:CommandTMaxHeight=8   " don't grow more than 8 lines
let g:CommandTMinHeight=8   " don't shrink less than 8 lines

if has("gui_macvim")
    " use ⌘E to activate (keep ⌘T for New Tab)
    map <D-E> :CommandT<CR>

    " flush Command-T buffer when there may be new files
    augroup AutoFlush
      autocmd!
      autocmd FocusGained * CommandTFlush  " flush on window focus
      autocmd BufWritePost * CommandTFlush " flush on write file
    augroup END
endif

" indent guides
let g:indent_guides_enable_on_vim_startup=1 " auto-enable
let g:indent_guides_start_level=1           " start guides at level 1
let g:indent_guides_color_change_percent=3  " show very low-contrast guides

if has("gui_running")
    let g:indent_guides_auto_colors=1 " automatically determine colors
else
    let g:indent_guides_auto_colors=0 " use custom colors in terminal
    hi IndentGuidesOdd ctermbg=none
    hi IndentGuidesEven ctermbg=black
endif

if has("gui_macvim")
    " press ⌘1 – ⌘9 to switch tabs
    nmap <D-1> 1gt
    nmap <D-2> 2gt
    nmap <D-3> 3gt
    nmap <D-4> 4gt
    nmap <D-5> 5gt
    nmap <D-6> 6gt
    nmap <D-7> 7gt
    nmap <D-8> 8gt
    nmap <D-9> 9gt
endif
