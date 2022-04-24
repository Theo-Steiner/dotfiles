local null_ls = require("null-ls")
local gitsigns = require("gitsigns")

local generate_source_with_fallback = function(source_command, source_generator, additional_config)
	local utils = require("null-ls.utils").make_conditional_utils()
	local project_local_bin = "node_modules/.bin/" .. source_command

	return source_generator({
		unpack(additional_config),
		command = utils.root_has_file(project_local_bin) and project_local_bin or source_command,
	})
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
})

-- use local eslint if available, otherwise fall back to global
local eslint = generate_source_with_fallback("eslint", null_ls.builtins.diagnostics.eslint.with, {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		prettier,
		eslint,
		null_ls.builtins.code_actions.gitsigns,
	},
	-- on attaching, create an autogroup for formatting on save
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_create_augroup("LspFormatting", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = "LspFormatting",
				buffer = vim.api.nvim_win_get_buf(0),
				callback = function()
					-- use formatting with the lsp that has the capabilities (normally only null-ls)
					vim.lsp.buf.formatting_sync()
					-- keep gitsigns in sync after formatting
					gitsigns.refresh()
				end,
			})
		end
	end,
})
