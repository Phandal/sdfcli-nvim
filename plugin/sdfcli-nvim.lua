if vim.g.loaded_sdfcli_nvim then
  return
end
vim.g.loaded_sdfcli_nvim = true

vim.api.nvim_create_user_command('SDFSetEnvironment', function()
  require('sdfcli-nvim').set_environment()
end, { desc = 'Set the current environment for the SDF plugin.' })
