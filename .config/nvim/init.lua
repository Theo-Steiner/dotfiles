local set = vim.opt
local keymap = vim.api.nvim_set_keymap

-- ****************************************
-- ********** BASIC VIM SETTINGS **********
-- ****************************************

-- because languages
set.encoding='UTF-8'

-- preferences for how stuff should be indented
set.tabstop=4 
set.softtabstop=4
set.shiftwidth=4
set.expandtab=true
set.smartindent=true

-- scroll screen 8 lines before the cursor hits the edge
set.scrolloff=8

-- activate linenumbers
set.number=true

-- remember folds for files that contain a dot (.) in their name
-- a new fold is made with visual line mode and then <za>
set.foldmethod='manual'

-- make linenumbers relative to cursor position
set.relativenumber=true

-- paste over selected content no longer replaces clipboard
-- && set clipboard to mac/windows system clipboard
keymap('v', 'p', '"_dP', {noremap = true})
set.cb='unnamed'

-- hides 'No write since last change (add ! to override)' error
set.hidden = true

 -- ****************************************
 -- ************** KEYBINDINGS *************
 -- ****************************************
 
 -- set leader to <space>
vim.g.mapleader = ' '

-- source vim config with <leader> enter
keymap('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>', {noremap = true})

-- use <leader> ff to open fuzzy finder preview to find file in project
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
-- use <leader> fg to open live_grep in preview window
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
-- use <leader> fg to open live_grep in preview window
keymap('n', '<leader>fs', '<cmd>Telescope git_status<cr>', {noremap = true})

-- <space> c toggles the current line or current selection to be a comment
keymap('', '<leader>c', 'gcc', {noremap = false})

-- open file tree with <leader> pv
-- TODO
-- nnoremap <leader>pv <Cmd>CocCommand explorer<CR> 

-- TODO coc related
-- enter on coc autocomplete suggestion selects first item
-- inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
-- configure tab to go down the auto selections and shift tab to go up
-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- jump to definition
-- nmap <silent> gd <Plug>(coc-definition)
-- jump to type definition
-- nmap <silent> gr <Plug>(coc-type-definition)
-- show type information in popup window
-- nmap <silent> gt :call <SID>show_documentation()<CR>

-- open diagnostics in a local list
-- nmap <silent> ge <Cmd>CocDiagnostics<CR> 

-- TODO quickfixlist nav function
-- navigate quickfixlist or location list using C-n and C-p
-- keymap('n', '<C-p>', ':call <SID>qfnavigation(v:false)<CR>', {noremap = true})
-- keymap('n', '<C-n>', ':call <SID>qfnavigation(v:true)<CR>', {noremap = true})

 -- ****************************************
 -- ********* MAKE VIM LOOK PRETTY *********
 -- ****************************************

 -- set colorscheme to dim
 vim.g.colors_name = 'dim'

-- Font that makes Coc-Explorer look nice and adds Powerline icons
set.guifont='Hack Nerd Font'
-- Highlight the line currently selected by making the text bold
set.cursorline=true

vim.cmd([[
    " Highlight the line currently selected by making the text bold
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
]])

-- ****************************************
-- ************** Packages *************
-- ****************************************
 
--
vim.cmd [[packadd packer.nvim]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
    -- Packer manages itself
    use 'wbthomason/packer.nvim'

    -- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- devicons for telescope && coc-explorer
    use 'kyazdani42/nvim-web-devicons'

    -- colortheme that only uses 16 ansi colors
    use 'jeffkreeftmeijer/vim-dim'

    -- surround selected code, mapped to shift-S
    use {'tpope/vim-surround', config = function()
            -- Custom svelte surroundings for tpope's vim-surround.
            -- in visual mode, hit <shift>-s to enter *vS* mode
            -- then hit the corresponding asci character to surround with snippet
            -- for await scaffolding: asci-97 => a
            vim.g.surround_97='{#await expression}\r{:then value} {value} {:catch error} {error} {/await}'
            -- for each block: asci-101 => e
            vim.g.surround_101='{#each iterable as value}\r{/each}'
            -- for if block: asci-105 => 
            vim.g.surround_105='{#if condition}\r{/if}'
        end
        }

    -- legendary git plugin
    use 'tpope/vim-fugitive'

    -- comment plugin... lol @tpope
    use 'tpope/vim-commentary'

    -- Github Copilot (secrectly tpope too)
    use 'github/copilot.vim'
    
    -- Git signs
    use 'lewis6991/gitsigns.nvim'

    -- statusline
    use { 'nvim-lualine/lualine.nvim', config = function()
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
                -- Once warpdotdev/Warp/issues/317 is resolved, section_separators can be the default value (,)
                section_separators = { left = '', right = ''},
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
    end }

end)
