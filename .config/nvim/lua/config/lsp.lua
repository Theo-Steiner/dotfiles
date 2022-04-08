-- setup lsp
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.set_preferences({
  set_lsp_keymaps = false,
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
})
lsp.nvim_workspace()
lsp.on_attach(function(client, bufnr)
  local noremap = {noremap = true}
  local map = function(...) vim.api.nvim_buf_set_map(0, ...) end

map( 'n', '<silent> gd', '<cmd>lua vim.lsp.buf.definition()<CR>', noremap)
map('n', '<silent> gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', noremap)
map( 'n', '<silent> gh', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap)
map( 'n', '<silent> gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', noremap)
map( 'n', '<silent> rn', '<cmd>lua vim.lsp.buf.rename()<CR>', noremap)
map( 'n', '<silent> ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', noremap)
map( 'n', '<silent> gr', '<cmd>lua vim.lsp.buf.references()<CR>', noremap)
map( 'n', '<leader> f', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremap)
end)
lsp.setup()
