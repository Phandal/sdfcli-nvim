local util = require('sdfcli-nvim.utils')
local config = require('sdfcli-nvim.config')

local M = {}

M.create_project = function()
  if not config.opts.sdf_installed then
    util.error_log("Cannot find 'sdfcli' in your $PATH")
    return
  end
  local cwd = util.get_cwd()
  util.clear_prompt()
  local input_opts = { prompt = 'Enter path to project: ', default = cwd, completion = 'file' }
  vim.ui.input(input_opts, function(project_path)
    if not project_path or util.file_exists(project_path) then
      util.clear_prompt()
      util.warn_log('That folder already exists!')
      return
    end

    local project_dir = util.get_base_path(project_path)
    local project_name = util.get_folder_name(project_path)

    util.clear_prompt()
    print(vim.fn.system(config.opts.sdfcli_cmd .. ' createproject -type ACCOUNTCUSTOMIZATION -parentdirectory ' .. project_dir .. ' -projectname ' .. project_name))
  end)
end

return M
