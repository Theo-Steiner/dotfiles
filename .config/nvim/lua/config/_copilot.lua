-- This config is here to make copilot play nicely with nvim-cmp
local cmp = require("cmp")
local check_back_space = function()
	local col = vim.fn.col(".") - 1
	if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		return true
	else
		return false
	end
end
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
return cmp.mapping(function(fallback)
	local copilot_keys = vim.fn["copilot#Accept"]()
	if copilot_keys ~= "" then
		vim.api.nvim_feedkeys(copilot_keys, "i", true)
	elseif cmp.visible() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	elseif check_back_space() then
		fallback()
	else
		cmp.complete()
	end
end, { "i", "s" })
