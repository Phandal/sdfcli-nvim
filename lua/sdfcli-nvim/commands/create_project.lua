local config = require('sdfcli-nvim.config')
local utils = require('sdfcli-nvim.utils')

local M = {}

M.create_project = function()
  if not config.opts.sdfInstalled then
    utils.error_log("Cannot find 'sdfcli' in your $PATH")
    return
  end

  local cwd = utils.get_cwd()
  local input_opts = { prompt = 'Enter path to project: ', default = cwd, completion = 'file' }
  vim.ui.input(input_opts, function(project_path)
    if not project_path or utils.file_exists(project_path) then
      utils.clear_prompt()
      utils.warn_log('That folder already exists!')
      return
    end

    local project_dir = utils.get_base_path(project_path)
    local project_name = utils.get_folder_name(project_path)

    utils.clear_prompt()
    print(vim.fn.system('sdfcli createproject -type ACCOUNTCUSTOMIZATION -parentdirectory ' .. project_dir .. ' -projectname ' .. project_name))
  end)
end

return M
