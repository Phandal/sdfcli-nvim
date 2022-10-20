if vim.g.loaded_sdfcli_nvim then
  return
end
vim.g.loaded_sdfcli_nvim = true

vim.api.nvim_create_user_command('SDFSetEnvironment', function()
  require('sdfcli-nvim').set_environment()
end, { desc = 'Set the current environment for the SDF plugin.' })

vim.api.nvim_create_user_command('SDFInfo', function()
  require('sdfcli-nvim').show_info()
end, { desc = 'Show current info about the state of the plugin.' })
