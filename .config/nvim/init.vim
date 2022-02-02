" THEO'S NVIM CONFIG FOR THE WARP TERMINAL
" ****************************************
" ************ CALL VIM PLUG *************
" ****************************************
"
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
" colortheme that only uses 16 ansi colors
Plug 'jeffkreeftmeijer/vim-dim'

" Github Copilot
Plug 'github/copilot.vim'
" get the current context inside a file - eg. current html / css / js,ts section in svelte
" necessary for proper comment toggling
Plug 'shougo/context_filetype.vim'

" comment plugin || toggle comment with <leader> c
Plug 'tyru/caw.vim'

" legendary git plugin
Plug 'tpope/vim-fugitive'

" git gutter shows changed lines in the sign column
Plug 'airblade/vim-gitgutter'

" surround selected code, mapped to shift-S
Plug 'tpope/vim-surround'

" statusline
Plug 'nvim-lualine/lualine.nvim'

" telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" preview for css colors inline
Plug 'ap/vim-css-color'

" vim polyglot provides syntax highlighting for pretty much everything
Plug 'sheerun/vim-polyglot'

" coc allows for the use of vs-code language server protocols in nvim
" 'do' installs all coc extensions specified in coc_global_extensions variable
Plug 'neoclide/coc.nvim', {'branch': 'release','do': { -> coc#util#install() }}

" devicons for telescope && coc-explorer
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()


" ****************************************
" ********** BASIC VIM SETTINGS **********
" ****************************************
"
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

" set clipboard to mac/windows system clipboard
set cb=unnamed

" because languages
set encoding=UTF-8

" Font that makes Coc-Explorer look nice and adds Powerline icons
set guifont=Hack\ Nerd\ Font

" hides 'No write since last change (add ! to override)' error
set hidden


" ****************************************
" ********* MAKE VIM LOOK PRETTY *********
" ****************************************
"
" set colorscheme to dim
syntax on
colorscheme dim

" Highlight the line currently selected by making the text bold
set cursorline
hi CursorLine term=bold cterm=bold

" Change color and always display sign column:
highlight! link SignColumn LineNr
" signcolumn not available for some reason?
" set signcolumn="yes"

" Make VerticalSplit thin and non-ugly
highlight VertSplit ctermfg=NONE ctermbg=NONE cterm=NONE
highlight SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE

" Customize lualine
hi StatusLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi StatusLineNC ctermfg=NONE ctermbg=NONE cterm=NONE
lua << END
local custom_auto = require'lualine.themes.auto'
-- Change the background of lualine_c section to NONE for all modes
custom_auto.normal.c.bg = NONE
custom_auto.visual.c.bg = NONE
custom_auto.insert.c.bg = NONE
custom_auto.command.c.bg = NONE
-- Change the background of lualine_b section to NONE for all modes
custom_auto.normal.b.bg = NONE 
custom_auto.visual.b.bg = NONE
custom_auto.insert.b.bg = NONE
custom_auto.command.b.bg = NONE
require'lualine'.setup  {
    options = {
        theme = custom_auto,
        component_separators = { left = '', right = ''},
    }
}
END

" ****************************************
" ********* SETTINGS FOR PLUGINS *********
" ****************************************
"


" enable typescript highlighting in svelte files 
" || vim-svelte-plugin is installed through vim polyglot ||
let g:vim_svelte_plugin_use_typescript = 1

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

" ****************************************
" ************** KEYBINDINGS *************
" ****************************************
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

" open file tree with <leader> pv
nnoremap <leader>pv <Cmd>CocCommand explorer<CR> 

" enter on coc autocomplete suggestion selects first item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" configure tab to go down the auto selections and shift tab to go up
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" jump to definition
nmap <silent> gd <Plug>(coc-definition)
" jump to type definition
nmap <silent> gr <Plug>(coc-type-definition)
" show type information in popup window
nmap <silent> gt :call <SID>show_documentation()<CR>

" open diagnostics in a local list
nmap <silent> ge <Cmd>CocDiagnostics<CR> 

" navigate quickfixlist or location list using C-n and C-p
nnoremap <C-p> :call <SID>qfnavigation(v:false)<CR>
nnoremap <C-n> :call <SID>qfnavigation(v:true)<CR>

function! s:qfnavigation(next) abort
    " find all 'quickfix'-type windows on the current tab
    let qfwin = filter(getwininfo(), {_, v -> v.quickfix && v.tabnr == tabpagenr()})
    if !empty(qfwin)
        " using the first one found
        if qfwin[0].winid == getqflist({'nr': 0, 'winid': 0}).winid
            " it's quickfix
            execute a:next ? 'cnext' : 'cprev'
        else
            " assume it's loclist
            " must execute it in the host window or in loclist itself
            call win_execute(qfwin[0].winid, a:next ? 'lnext' : 'lprev', '')
        endif
    endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction 


" ****************************************
" ************* AUTOCOMMANDS *************
" ****************************************
"
" Close coc-explorer if it's the only buffer left open.
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
