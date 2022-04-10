-- ****************************************
-- ********** BASIC VIM SETTINGS **********
-- ****************************************

-- because languages
Set.encoding='UTF-8'

-- preferences for how stuff should be indented
Set.tabstop=4 
Set.softtabstop=4
Set.shiftwidth=4
Set.expandtab=true
Set.smartindent=true

-- scroll screen 8 lines before the cursor hits the edge
Set.scrolloff=8

-- activate linenumbers
Set.number=true

-- make linenumbers relative to cursor position
Set.relativenumber=true

-- remember folds for files that contain a dot (.) in their name
-- a new fold is made with visual line mode and then <za>
Set.foldenable=false
Set.foldmethod='expr'
Set.foldexpr='nvim_treesitter#foldexpr()'

-- paste over selected content no longer replaces clipboard
-- && set clipboard to mac/windows system clipboard
Map('v', 'p', '"_dP', Noremap)
Set.cb='unnamed'

-- hides 'No write since last change (add ! to override)' error
Set.hidden = true

 -- ****************************************
 -- ********* MAKE VIM LOOK PRETTY *********
 -- ****************************************

-- enable all the colors
Set.termguicolors=true

-- Font that makes Coc-Explorer look nice and adds Powerline icons
Set.guifont='Hack Nerd Font'
-- Highlight the line currently selected by making the text bold
Set.cursorline=true

