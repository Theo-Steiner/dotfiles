-- ****************************************
-- ************** Completions *************
-- ****************************************

-- configure lsp-zero, a wrapper around nvim-cmp for n00bs like me
require("config._lsp-zero")

-- configure null-ls, a "fake language server that allows processes
-- like prettier/eslint to hook into nvim's lsp-service
require("config._null-ls")

-- add .svelte filetype to plenary (for telescope highlighting)
require("plenary.filetype").add_file("added")

-- add global to track if auto formatting is enabled
vim.g.AutoFormattingEnabled = true
vim.cmd([[command! Formatting lua vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled]])
