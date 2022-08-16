local config = require('sdfcli-nvim.config')
local util = require('sdfcli-nvim.utils')

local M = {}

local function spawn()
  local stdin = vim.loop.new_pipe(false)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local handle
  local buf = ''

  local function on_read(err, data)
    assert(not err, error)
    if data then
      buf = buf .. data
    end
  end

  local function print_cmd_output()
    vim.notify(buf, vim.log.levels.INFO)
    vim.fn.setqflist({}, 'a', {title = 'TEST', lines = vim.split(buf, '\n')}) -- Testing purposes only.
    buf = ''
  end

  handle = vim.loop.spawn(config.opts.sdfcli_cmd, {
      args = {'deploy', '-authid', config.opts.environment, '-p', config.opts.project_dir, '-sw'},
      stdio = {stdin, stdout, stderr}
    },
    vim.schedule_wrap(function()
      stdin:shutdown()
      stdin:close()
      stdout:read_stop()
      stderr:read_stop()
      stdout:close()
      stderr:close()
      handle:close()
      print_cmd_output()
    end)
  )

  stdout:read_start(on_read)
  stderr:read_start(on_read)
  
  stdin:write('y\n')
end

M.deploy_project = function()
  if not config.is_ready() then
    return
  end

  if not config.opts.environment then
    config.set_environment()
  end

  -- Start the command here
  spawn()

end

return M
