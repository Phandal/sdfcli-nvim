if vim.g.loaded_sdfcli_nvim then
  return
end
vim.g.loaded_sdfcli_nvim = true

vim.api.nvim_create_user_command('SDFCreateProject', function()
  require('sdfcli-nvim').create_project()
end, { desc = 'Create an SDF project' })

vim.api.nvim_create_user_command('SDFDeployProject', function()
  require('sdfcli-nvim').deploy_project()
end, { desc = 'Deploy project to Netsuite' })

vim.api.nvim_create_user_command('SDFSwitchEnvironments', function()
  require('sdfcli-nvim').switch_environments()
end, { desc = 'Switch between environments in .sdfcli.json'})
