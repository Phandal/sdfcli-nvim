if vim.g.loaded_sdfcli_nvim then
  return
end
vim.g.loaded_sdfcli_nvim = true

vim.api.nvim_create_user_command('SDFCreateProject', function()
  require("sdfcli-nvim").create_project()
end, { desc = 'Create an SDF project' })

-- vim.api.nvim_create_user_command("FetchTodos", function()
--   require("sdfcli-nvim").fetch_todos()
-- end, { desc = "Get all uncompleted Todos"})
