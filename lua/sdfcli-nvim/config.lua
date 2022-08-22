local util = require('sdfcli-nvim.utils')
local json = require('sdfcli-nvim.json')

local M = {}

-- Default options
local defaults = {
  -- Start here
  sdfcli_cmd = '/sdfcli/sdfcli.bat',
}

M.check_sdf_installed = function()
  return vim.fn.executable(M.opts.sdfcli_cmd) == 1
end

M.set_project_dir = function()
  local cwd = util.get_cwd()
  local input_opts = { prompt = 'Enter the path to the project root: ', default = cwd, completion = 'file' }
  vim.ui.input(input_opts, function(project_path)
    if not project_path then
      return
    elseif not util.file_exists(project_path) then
      util.clear_prompt()
      util.warn_log('That is not a valid folder!')
    else
      project_path = util.remove_trailing_slash(project_path)
      M.opts.project_dir = project_path
      util.clear_prompt()
      util.info_log('Project path set to: ' .. project_path)
    end
  end)
end

M.is_ready = function()
  if not M.opts.sdf_installed then
    util.error_log("Cannot find 'sdfcli' in your $PATH")
    return false
  end

  if not M.opts.project_dir then
    M.set_project_dir()
    if not M.opts.project_dir then
      return false
    end
  end

  return true
end

M.set_environment = function()
  if not M.opts.project_dir then
    M.set_project_dir()
  end
  local sdfcli_opts = M.get_sdf_config()
  if not sdfcli_opts then
    util.error_log("Cannot read '.sdfcli.json'")
    return
  end
  local envs = {}
  for i, v in ipairs(sdfcli_opts.environments) do
    envs[i] = v.name
  end
  local select_opts = { prompt = 'Please choose an environment:' }
  vim.ui.select(envs, select_opts, function(env)
    if env then
      for _, v in ipairs(sdfcli_opts.environments) do
        if v.name == env then
          M.opts.environment = '"' .. v.authid .. '"'
          util.info_log('Netsuite Account set to: ' .. v.name)
        end
      end
    end
  end)
end

M.get_sdf_config = function()
  local sdfcli_path = util.add_trailing_slash(M.opts.project_dir) .. '.sdfcli.json'
  if not util.file_exists(sdfcli_path) then
    util.error_log("'.sdfcli.json' not found in project root.")
    return false
  end
  local opts_handle = vim.loop.fs_open(sdfcli_path, 'r', 438)
  local opts_stat = vim.loop.fs_fstat(opts_handle)
  local sdfcli_opts_data = vim.loop.fs_read(opts_handle, opts_stat.size, 0)
  vim.loop.fs_close(opts_handle)
  return json.decode(sdfcli_opts_data)
end

-- Setup function to setup the config
function M.setup(opts)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opts or {})
  M.opts.sdf_installed = M.check_sdf_installed()
end

M.setup()

return M
