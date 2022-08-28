if vim.g.loaded_sdfcli_nvim then
  return
end
vim.g.loaded_sdfcli_nvim = true

vim.api.nvim_create_user_command('SDFHello', function()
  require('sdfcli-nvim').hello()
end, { desc = 'Print Hello World' })
