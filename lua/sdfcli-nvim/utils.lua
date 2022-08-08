local loop = vim.loop

local M = {}

M.path_sep = package.config:sub(1, 1)

M.get_cwd = function()
  local cwd = loop.fs_realpath(loop.cwd())
  cwd = cwd .. M.path_sep
  return cwd
end

M.get_base_path = function(path)
  path = M.remove_trailing_slash(path)
  local index = path:match('^.*()' .. M.path_sep)
  if index then
    return path:sub(0, index)
  end
end

M.get_folder_name = function(path)
  path = M.remove_trailing_slash(path)
  local index = path:match('^.*()' .. M.path_sep)
  if index then
    return path:sub(index + 1)
  end
  return path
end

M.remove_trailing_slash = function(path)
  local new_path, _ = path:gsub(M.path_sep .. '$', '')
  return new_path
end

M.clear_prompt = function()
  vim.api.nvim_command('normal! :')
end

M.file_exists = function(path)
  local _, error = loop.fs_stat(path)
  return error == nil
end

M.info_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.INFO)
  end)
end

M.warn_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN)
  end)
end

M.error_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.ERROR)
  end)
end

return M
