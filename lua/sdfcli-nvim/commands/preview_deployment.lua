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
  local lines = vim.fn.systemlist(config.opts.sdfcli_cmd .. ' preview -authid ' .. config.opts.environment .. ' -p ' .. config.opts.project_dir)
  local opts = { width = math.ceil(vim.o.columns * 0.8), height = math.ceil(vim.o.lines * 0.8) }
  utils.create_float(lines, opts)
end

return M
