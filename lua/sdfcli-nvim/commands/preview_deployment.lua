local config = require('sdfcli-nvim.config')
local utils = require('sdfcli-nvim.utils')

local M = {}

M.preview_deployment = function()
  if not config.is_ready then
    return
  end

  if not config.opts.environment then
    config.set_environment()
  end

  utils.clear_prompt()
  print(vim.fn.system(config.opts.sdfcli_cmd .. ' preview -authid ' .. config.opts.environment .. ' -p ' .. config.opts.project_dir))
end

return M
