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

-- add custom keybinding for copilot
require("config._copilot")

-- add global to track if auto formatting is enabled
vim.g.AutoFormattingEnabled = true
vim.cmd([[command! Formatting lua vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled]])
vim.cmd([[command! Fmt lua vim.lsp.buf.formatting_sync()]])
vim.cmd([[command! Format lua vim.lsp.buf.formatting_sync()]])
