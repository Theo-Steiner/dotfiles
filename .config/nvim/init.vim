" scroll screen 8 lines before the cursor hits the edge
set scrolloff=8
" activate linenumbers
set number
" make linenumbers relative to cursor position
set relativenumber
" preferences for how stuff should be indented
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" enable iTerm colors
set termguicolors
" for my eyes
set background=dark
" set clipboard to mac/windows system clipboard
set cb=unnamed
" because languages
set encoding=UTF-8
" Font that makes Coc-Explorer look nice and adds Powerline icons
set guifont=Hack\ Nerd\ Font

set hidden

" specifies the addons language servers coc should install/ check for on vim startup
let g:coc_global_extensions = [
                  \ 'coc-explorer',
                  \ 'coc-prettier',
                  \ 'coc-tsserver',
                  \ 'coc-svelte',
                  \ 'coc-json',
                  \ 'coc-css',      
                  \ 'coc-eslint',      
                  \ 'coc-html']

call plug#begin('~/.vim/plugged')
" pretty theme
Plug 'overcache/NeoSolarized'

" get the current context inside a file - eg. current html / css / js,ts section in svelte
" necessary for proper comment toggling
Plug 'shougo/context_filetype.vim'
"
" comment plugin || toggle comment with <leader> c
Plug 'tyru/caw.vim'

" legendary git plugin
Plug 'tpope/vim-fugitive'

" git gutter shows changed lines in the sign column
Plug 'airblade/vim-gitgutter'

" surround selected code, mapped to shift-S
Plug 'tpope/vim-surround'

" sexy lightline plugin
Plug 'itchyny/lightline.vim'

" add git hunks to lightline
Plug 'sinetoami/lightline-hunks'

" telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" preview for css colors inline
Plug 'ap/vim-css-color'

" vim polyglot provides syntax highlighting for pretty much everything
Plug 'sheerun/vim-polyglot'

" coc allows for the use of vs-code language server protocols in nvim
" 'do' installs all coc extensions specified in coc_global_extensions variable
Plug 'neoclide/coc.nvim', {'branch': 'release','do': { -> coc#util#install() }}
call plug#end()
" enable typescript highlighting in svelte files 
" || vim-svelte-plugin is installed through vim polyglot ||
let g:vim_svelte_plugin_use_typescript = 1

" configure and set colorscheme
let g:neosolarized_contrast = "high"
colorscheme NeoSolarized

" configure context_filetype.vim for svelte
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script \?.*>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '</script>',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\   {
\    'filetype': 'html',
\    'start': '',
\    'end': '',
\   },
\ ]

" settings for lightline (powerline symbols as separator/subseparator +
" display relative filepath + show gitbranch && git hunks)
let g:lightline = {
      \ 'colorscheme': 'customized_solarized',
      \ 'background' : 'dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'lightline_hunks'], 
      \             ['readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'GetCurrentGitPath',
      \   'lightline_hunks': 'lightline#hunks#composer',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ }

" get the path relative to the git repo to add it to the status line.
" If window is too small, file and parent directory are shown instead.
function! GetCurrentGitPath()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Use git gutter to check if changes have been made since the last git commit
" and change the Git part of the statusline color to yellow if dirty
function! GitColorAndHunks()
  let hunks = GitGutterGetHunkSummary()
  let l:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
  if hunks[0] == 0 && hunks[1] == 0 && hunks[2] == 0
     let l:palette.normal.left[1][1] = '#859900'
  else
     let l:palette.normal.left[1][1] = '#b58900'
  endif
  call lightline#colorscheme()
endfunction
   
autocmd BufWritePost * call GitColorAndHunks() 

"
" set leader to <space>
let mapleader=" "
      
" paste over selected content no longer replaces clipboard
vnoremap p "_dP

" source vim config with <leader> enter
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" use <leader> ff to open fuzzy finder preview to find file in project
nnoremap <leader>ff <cmd>Telescope find_files<cr>
" use <leader> fg to open live_grep in preview window
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" use <leader> fg to open live_grep in preview window
nnoremap <leader>fs <cmd>Telescope git_status<cr>

" <space> c toggles the current line or current selection to be a comment
map <leader>c <Plug>(caw:hatpos:toggle)

" have vim start coc-explorer if vim started with folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'CocCommand explorer' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" open file tree with <leader> pv
nnoremap <leader>pv <Cmd>CocCommand explorer<CR> 

" enter on coc autocomplete suggestion selects first item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" configure tab to go down the auto selections and shift tab to go up
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" jump to definition
nmap <silent> gd <Plug>(coc-definition)
" show type information in popup window
nmap <silent> gt :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction 
