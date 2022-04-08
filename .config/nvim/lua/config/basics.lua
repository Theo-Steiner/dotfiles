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

-- make linenumbers relative to cursor position
set.relativenumber=true

-- remember folds for files that contain a dot (.) in their name
-- a new fold is made with visual line mode and then <za>
set.foldenable=false
set.foldmethod='expr'
set.foldexpr='nvim_treesitter#foldexpr()'

-- paste over selected content no longer replaces clipboard
-- && set clipboard to mac/windows system clipboard
keymap('v', 'p', '"_dP', {noremap = true})
set.cb='unnamed'

-- hides 'No write since last change (add ! to override)' error
set.hidden = true

 -- ****************************************
 -- ********* MAKE VIM LOOK PRETTY *********
 -- ****************************************

-- enable all the colors
set.termguicolors=true

-- Font that makes Coc-Explorer look nice and adds Powerline icons
set.guifont='Hack Nerd Font'
-- Highlight the line currently selected by making the text bold
set.cursorline=true

