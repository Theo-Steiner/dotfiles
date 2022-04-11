-- ****************************************
-- ********* MAKE VIM LOOK PRETTY *********
-- ****************************************

-- enable all the colors
Set.termguicolors = true

-- make ~ chars disappear
Set.fillchars = "eob: "

-- Font that makes Coc-Explorer look nice and adds Powerline icons
Set.guifont = "Hack Nerd Font"
-- Highlight the line currently selected by making the text bold
Set.cursorline = true

require("warped").setup()

vim.cmd([[hi CursorLine guibg=NONE gui=bold]])
vim.cmd([[hi Folded guibg=NONE guifg=#fefefe]])
vim.cmd([[hi Normal guifg=NONE guibg=NONE]])
vim.cmd([[hi VertSplit gui=NONE guibg=NONE]])
vim.cmd([[hi LineNr guibg=NONE guifg=NONE]])
vim.cmd([[hi SignColumn guibg=NONE]])
