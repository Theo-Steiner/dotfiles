-- setup lsp
local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.set_preferences({
	set_lsp_keymaps = false,
	sign_icons = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
})
local default_servers = {
	"html",
	"cssls",
	"tsserver",
	"svelte",
	"sumneko_lua",
}
lsp.ensure_installed(default_servers)
local disable_native_formatting = function(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end
for _, servername in pairs(default_servers) do
	local additional_config
	if servername == "sumneko_lua" then
		additional_config = {
			Lua = {
				diagnostics = {
					globals = { "vim", "use" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/init.lua"),
					},
				},
			},
		}
	end
	lsp.configure(servername, { on_attach = disable_native_formatting, settings = additional_config })
end
lsp.setup()

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
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
			command = "./node_modules/.bin/prettier",
		}),
		null_ls.builtins.diagnostics.eslint.with({
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
