-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************

-- source vim config with <leader> enter
Map("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- use <leader> ff to open fuzzy finder preview to find file in project
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- use <leader> fg to open live_grep in preview window
Map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
-- use <leader> fg to open live_grep in preview window
Map("n", "<leader>fs", "<cmd>Telescope git_status<cr>")

-- <space> c toggles the current line or current selection to be a comment
Map("", "<leader>c", ":Commentary<CR>")

-- open file tree with <leader> pv
Map("n", "<leader>pv", ":Neotree reveal toggle<cr>")

-- LSP actions
-- show information about code at cursor position
Map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
--
Map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
Map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
Map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
Map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
Map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
Map("n", "s", "<cmd>lua vim.lsp.buf.rename()<cr>")
Map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

-- Diagnostics
Map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
local next_diagnostic_or_trouble = function(forwards)
	local trouble = require("trouble")
	local is_trouble_open
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if string.match(vim.api.nvim_buf_get_name(buffer), "Trouble") then
			is_trouble_open = true
		end
	end
	if is_trouble_open then
		if forwards then
			trouble.next({ skip_groups = true, jump = true })
		else
			trouble.previous({ skip_groups = true, jump = true })
		end
		return
	end
	if forwards then
		vim.diagnostic.goto_next()
	else
		vim.diagnostic.goto_prev()
	end
end
Map("n", "<C-p>", function()
	next_diagnostic_or_trouble(false)
end)
Map("n", "<C-n>", function()
	next_diagnostic_or_trouble(true)
end)

-- Populate trouble with document diagnostics
Map("n", "<C-t>", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true })
