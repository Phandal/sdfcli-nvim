local config = require('sdfcli-nvim.config')
local utils = require('sdfcli-nvim.utils')
local ui = require('sdfcli-nvim.ui')

local M = {}

M.preview_deployment = function()
  if not config.is_ready then
    return
  end

  if not config.opts.environment then
    config.set_environment()
  end

  utils.clear_prompt()
  local lines = vim.fn.systemlist(config.opts.sdfcli_cmd .. ' preview -authid ' .. config.opts.environment .. ' -p ' .. config.opts.project_dir)
  ui.create_float(lines, {})
end

return M
