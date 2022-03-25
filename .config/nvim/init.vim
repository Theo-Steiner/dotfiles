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

" open coc-explorer rather than netrw
augroup CocHijackScript
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | silent! bd | exe 'CocCommand explorer ' . d | endif
augroup END

" remember folds for files that contain a dot (.) in their name
" a new fold is made with visual line mode and then <za>
set foldmethod=manual
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

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
highlight GitGutterAdd ctermfg=2 ctermbg=NONE
highlight GitGutterChange ctermfg=3 ctermbg=NONE
highlight GitGutterDelete ctermfg=1 ctermbg=NONE
highlight GitGutterChangeDelete ctermfg=4 ctermbg=NONE
" signcolumn not available for some reason?
" set signcolumn="yes"

" Make VerticalSplit thin and non-ugly
highlight VertSplit ctermfg=NONE ctermbg=NONE cterm=NONE
highlight SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE

hi Folded ctermbg=NONE

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
-- make section c font bold
custom_auto.normal.c.gui = 'bold'
custom_auto.visual.c.gui = 'bold'
custom_auto.insert.c.gui = 'bold'
custom_auto.command.c.gui = 'bold'

-- a utility to trim the path if it is longer than 45 characters
function format_path(str) 
    if string.len(str) < 45 then
        return str
    end
    s = {}
    for i in string.gmatch(str, "([^/]+)") do
       table.insert(s,i)
    end
    res = ""
    for i=1, #s do
       if i < 3 then
          res = "/" .. s[#s + 1 - i] ..  res
       else
         return "..." .. res
       end
    end
    return "..." .. res
end

local utils = require('lualine.utils.utils')
require'lualine'.setup  {
    options = {
        theme = custom_auto,
        component_separators = { left = '', right = ''},
    },
    sections = {
        lualine_c = {
        }, 
        lualine_x = {
            {
                'filetype',
                icon_only = true,
                padding = 0,
                separator = '', 
            },
            {
                'filename',
                color = {gui = 'bold', fg = utils.extract_color_from_hllist('fg', { 'Special', 'Boolean', 'Constant' }, '#000000'), } ,
                path = 1, -- 1: relative path
                fmt = format_path,
            }
        },
    }
}
END

" ****************************************
" ********* SETTINGS FOR PLUGINS *********
" ****************************************
"


" Custom svelte surroundings for tpope's vim-surround.
" in visual mode, hit <shift>-s to enter *vS* mode
" then hit the corresponding asci character to surround with snippet
" for await scaffolding: asci-97 => a
let g:surround_97 = "{#await expression}\r{:then value} {value} {:catch error} {error} {/await}"
" for each block: asci-101 => e
let g:surround_101 = "{#each iterable as value}\r{/each}"
" for if block: asci-105 => i
let g:surround_105 = "{#if condition}\r{/if}"

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

" s can be used for changing all occurences of word under cursor
:nnoremap s :%s/\<<C-r><C-w>\>//g<Left><Left>

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
