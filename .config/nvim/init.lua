set = vim.opt
keymap = vim.api.nvim_set_keymap

noremap = {noremap = true}
map = function(...) vim.api.nvim_buf_set_keymap(0, ...) end

-- reload lua modules
reload = function()   
  for name,_ in pairs(package.loaded) do
    if name:match('^config') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end

require('config.basics')
require('config.keybindings')
require('config.packages')
require('config.lsp')
