let g:python3_host_prog="~/.config/nvim/.venv/bin/python"
source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           CORE OPTIONS                            === "
" ============================================================================ "


let g:mapleader=','
set autochdir                  " Change directory automatically
set clipboard=unnamedplus     " Yank and paste with the system clipboard
set hidden                     " Hides buffers instead of closing them
set backspace=indent,eol,start " make backspaces more powerful
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set autoindent
set nocursorline               " don't highlight current cursor line
set cmdheight=1                " Only one line for command line
"set shortmess+=c
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=3
set ignorecase
set smartcase  " if the search string has an upper case letter in it, the search will be case sensitive
set autoread " Automatically re-read file if a change was detected outside of vim
set mouse=a
set guifont=Fira\ Code\ Retina:h14
set splitright
set number relativenumber
set termguicolors
set fillchars+=vert:.
set title
set nowrap
" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" Reload config
nmap <F5> <Cmd>source $MYVIMRC<CR>

" Edit common configs
nmap <F6> <Cmd>tabnew $MYVIMRC<CR>
nmap <F7> <Cmd>tabnew $HOME/.zshrc<CR>
nmap <F8> <Cmd>tabnew $HOME/.config/kitty/kitty.conf<CR>
nmap <F9> <Cmd>tabnew $HOME/.config/ranger/rifle.conf<CR>
nmap <F10> <Cmd>VimwikiTabIndex<CR>

" Yank current filename
nmap <F2> <Cmd>let @" = expand("%")<CR>

" Makes folding Easier
noremap <Space> za

" Esc-related
imap jk <Esc>
tnoremap <Esc> <C-\><C-n>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" easy shortcut for removing highlights from a search
nmap <silent> <Leader>/ <Cmd>nohlsearch<CR>

" Pressing ctrl + / toggles comment, like in an IDE.
let g:NERDCreateDefaultMappings = 0 " Disables default nerdcommenter mappings
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle


" Make gf open non-existent files
map gf :edit <cfile><cr>

" Make Y behave like the other capitals
nnoremap Y y$

" Open the current file in the default program
nmap <leader>x :!open %<cr><cr>

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Tab navigation
nnoremap [t <Cmd>tabp<CR>
nnoremap ]t <Cmd>tabn<CR>
nnoremap <C-t> <Cmd>tabnew<CR>

nnoremap # <Cmd>Telescope grep_string<CR>

nnoremap <leader>o <Cmd>only<CR> 

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

let g:signify_sign_delete = '-'

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile


" ============================================================================ "
" ===                             SOURCING                                 === "
" ============================================================================ "

source $NEOHOME/vimscript/float.vim

"function SourceIfExists(file)
  "if filereadable(expand(a:file))
    "source expand(a:file)
  "endif
"endfunction

"call SourceIfExists("~/.vim/ftdetect/xonsh.vim")
"set runtimepath^=~/.vim

lua << EOF
require("lsp")
require("tele-scope")
require("sitter")
require("completion")
require("tree")
require("line")
require("colors")
require("notes")
require("mark")
require("misc")
require("ui")
EOF


