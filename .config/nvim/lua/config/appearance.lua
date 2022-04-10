-- ****************************************
-- ********* MAKE VIM LOOK PRETTY *********
-- ****************************************

-- enable all the colors
Set.termguicolors = true
-- set theme
vim.cmd([[colorscheme dracula]])

-- make ~ chars disappear
Set.fillchars = "eob: "

-- Font that makes Coc-Explorer look nice and adds Powerline icons
Set.guifont = "Hack Nerd Font"
-- Highlight the line currently selected by making the text bold
Set.cursorline = true
