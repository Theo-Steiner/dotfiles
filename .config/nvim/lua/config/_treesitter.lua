require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "phpdoc" },

	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		-- this indentation currently over indents after closing a tag
		enable = false,
	},
	context_commentstring = {
		enable = true
	}
})
