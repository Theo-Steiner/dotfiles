-- ****************************************
-- ************** Completions *************
-- ****************************************

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
-- a list of servers that
local default_servers = {
	"html",
	"cssls",
	"tsserver",
	"svelte",
	"sumneko_lua",
}
-- (1) are ensured to be installed
lsp.ensure_installed(default_servers)
-- and (2) are formatted by null-ls and therefore have their format capabilities disabled
local disable_native_formatting = function(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end
for _, servername in pairs(default_servers) do
	local additional_config
	-- config for specific LSPs (e.g. setup lua workspace/globals)
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

-- configure null-ls, a "fake language server that allows processes
-- like prettier/eslint to hook into nvim's lsp-service
local null_ls = require("null-ls")
local gitsigns = require("gitsigns")
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

-- add .svelte filetype to plenary (for telescope highlighting)
require("plenary.filetype").add_file("added")
