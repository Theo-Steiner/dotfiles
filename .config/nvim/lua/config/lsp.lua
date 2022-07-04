-- ****************************************
-- ************** Formatting **************
-- ****************************************

-- add global to track if auto formatting is enabled
vim.g.AutoFormattingEnabled = true

-- add commands for to format and toggle auto formatting
vim.cmd([[command! Formatting lua vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled]])
vim.cmd([[command! Fmt lua vim.lsp.buf.formatting_sync()]])
vim.cmd([[command! Format lua vim.lsp.buf.formatting_sync()]])

-- augroup for formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- attach this handler as on_attach callback to enable lsp autoformatting
AUTO_FORMAT = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				-- 			-- TODO: on 0.8 => vim.lsp.buf.format({ bufnr = bufnr }) instead
				vim.lsp.buf.formatting_sync()
				-- 			-- keep gitsigns in sync after formatting
				require("gitsigns").refresh()
			end,
		})
	end
end

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
