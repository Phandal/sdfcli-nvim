local utils = require('sdfcli-nvim.utils')

local M = {}

local read_sdf_config = function(json_path)
  local opts_handle = vim.loop.fs_open(json_path, 'r', 438)
  local opts_stat = vim.loop.fs_fstat(opts_handle)
  local sdfcli_opts_data = vim.loop.fs_read(opts_handle, opts_stat.size, 0)
  vim.loop.fs_close(opts_handle)
  return vim.json.decode(sdfcli_opts_data)
end

M.defaults = {
  sdfcli_cmd_path = '/sdfcli/sdfcli.bat',
}

M.is_command_executable = function(cmd)
  return vim.fn.executable(cmd) == 1
end

M.find_project_dir = function(path)
  for _ = 1, 100 do
    if utils.is_fs_root(path) then
      return nil
    end
    if utils.file_exists(path .. utils.path_sep .. '.sdfcli.json') then
      return path
    end
    local index = path:match('^.*()' .. utils.path_sep)
    path = path:sub(0, index)
  end
  return nil
end

local _set_environment = function(choice)
  if (choice) then
    for _, v in pairs(sdfcli_opts.environments) do
      if v.name == choice then
        M.opts.environment_name = v.name
        M.opts.environment_value = v.authid
        return
      end
    end
  end
end

M.set_environment = function()
  assert(M.opts.project_dir, 'Project directory not set')
  local json_path = M.opts.project_dir .. utils.path_sep .. '.sdfcli.json'
  assert(utils.file_exists(json_path), 'Cannot find .sdfcli.json')

  local sdfcli_opts = read_sdf_config(json_path)
  assert(sdfcli_opts.environments, 'Could not find environments property in .sdfcli.json')
  local envs = {}
  for i, v in pairs(sdfcli_opts.environments) do
    envs[i] = v.name
  end

  local select_opts = { prompt = 'Please choose an environment:' }
  vim.ui.select(envs, select_opts, function(choice) _set_environment(choice) end)
end

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend('force', {}, M.defaults, opts)
  M.opts.has_command = M.is_command_executable(M.opts.sdfcli_cmd_path)
  M.opts.project_dir = M.find_project_dir(vim.fn.getcwd())
  M.opts.environment_name = nil
  M.opts.environment_value = nil
end

M.setup({})

return M
