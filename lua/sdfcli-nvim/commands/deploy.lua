local config = require('sdfcli-nvim.config')
local util = require('sdfcli-nvim.utils')

local M = {}

M.deploy = function()
  if not config.is_ready() then
    return
  end

  if not config.opts.environment then
    config.set_environment()
  end

  local stdin = vim.loop.new_pipe()
  local stdout = vim.loop.new_pipe()
  local stderr = vim.loop.new_pipe()

  local spawn_opts = {
    args = {'deploy', '-authid', config.opts.environment, '-p', config.opts.project_dir},
    stdio = {stdin, stdout, stderr},
    hide = true,
  }

  local handle, pid = vim.loop.spawn('sdfcli', spawn_opts, function(code, signal)
    print('code', code)
    print('signal', signal)
  end)

  vim.loop.read_start(stdout, function(err, data)
    assert(not err, err)
    if data then
      print('stdout chunk', data)
    end
  end)

  vim.loop.close(handle, function()
    print('process closed')
  end)
  -- vim.fn.system(command)
end

return M
