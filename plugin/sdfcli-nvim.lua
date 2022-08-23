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

vim.api.nvim_create_user_command('SDFPreviewDeployment', function()
  require('sdfcli-nvim').preview_deployment()
end, { desc = 'Preview the deployment' })

vim.api.nvim_create_user_command('SDFSetEnvironment', function()
  require('sdfcli-nvim').set_environment()
end, { desc = 'Switch between environments in .sdfcli.json' })

vim.api.nvim_create_user_command('SDFInfo', function()
  require('sdfcli-nvim').info_display()
end, { desc = 'Show info about currect SDF project' })
