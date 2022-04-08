 -- ****************************************
 -- ************** KEYBINDINGS *************
 -- ****************************************
 
 -- set leader to <space>
vim.g.mapleader = ' '

-- source vim config with <leader> enter
keymap('n', '<leader><CR>', "<cmd>lua reload()<cr>", {noremap = true})

-- use <leader> ff to open fuzzy finder preview to find file in project
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
-- use <leader> fg to open live_grep in preview window
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
-- use <leader> fg to open live_grep in preview window
keymap('n', '<leader>fs', '<cmd>Telescope git_status<cr>', {noremap = true})

-- <space> c toggles the current line or current selection to be a comment
keymap('', '<leader>c', 'gcc', {noremap = false})

-- open file tree with <leader> pv
keymap('n', '<leader>pv', ':Neotree reveal toggle<cr>', {noremap = false})


-- navigate quickfixlist or location list using C-n and C-p
keymap('n', '<C-p>', ':call <SID>qfnavigation(v:false)<CR>', {noremap = true})
keymap('n', '<C-n>', ':call <SID>qfnavigation(v:true)<CR>', {noremap = true})
vim.cmd([[
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
]])
