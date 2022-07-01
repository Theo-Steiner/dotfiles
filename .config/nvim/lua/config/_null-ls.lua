local null_ls = require("null-ls")
local gitsigns = require("gitsigns")

local generate_source_with_fallback = function(source_command, source_generator, config, additional_args)
	config = config or {}
	local utils = require("null-ls.utils").make_conditional_utils()
	local project_local_bin = "node_modules/.bin/" .. source_command

	local command = utils.root_has_file(project_local_bin) and project_local_bin or source_command
	config["command"] = command
	-- TODO: once prettier implements a new algorithm for searching for plugins, its extra args no longer have to be passed
	config["extra_args"] = additional_args
	return source_generator(config)
end

-- use local prettier if available, otherwise fall back to global
local prettier = generate_source_with_fallback("prettier", null_ls.builtins.formatting.prettier.with, {
	filetypes = {
		"svelte",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"css",
		"scss",
		"less",
		"html",
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"graphql",
		"handlebars",
	},
	-- TODO: prettier plugin not found with pnpm, unless below line included
	-- upstream issue: prettier/prettier/pull/11248
}, { "--plugin-search-dir=." })

-- use local eslint if available, otherwise fall back to global
local eslint = generate_source_with_fallback("eslint", null_ls.builtins.diagnostics.eslint.with, {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
})

-- augroup for formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		prettier,
		eslint,
		null_ls.builtins.code_actions.gitsigns,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
		-- 			-- TODO: on 0.8 => vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
		-- 			-- keep gitsigns in sync after formatting
					gitsigns.refresh()
				end,
			})
		end
	end,
})
