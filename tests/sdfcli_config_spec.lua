local config = require('sdfcli-nvim.config')
local utils = require('sdfcli-nvim.utils')

describe('The setup function', function()

  it('merges users options with default options', function()
    config.setup({ sdfcli_cmd_path = '~/.local/bin/sdfcli'})
    local sdfcli_cmd_path = '~/.local/bin/sdfcli'

    assert.equal(sdfcli_cmd_path, config.opts.sdfcli_cmd_path)
  end)

  it('looks for the project dir', function()
    local project_path = vim.fn.getcwd()

    assert.equal(project_path, config.opts.project_dir)
  end)
end)

describe('The set_environment function', function()
  it('checks if `.sdfcli.json` exists', function()
    local old_json_path = config.opts.project_dir .. utils.path_sep .. '.sdfcli.json'
    local new_json_path = config.opts.project_dir .. utils.path_sep .. '.sdfcli.json.old'
    local code= vim.fn.rename(old_json_path, new_json_path)
    assert(code, 'File was not changed')
    assert.has_error(function () config.set_environment() end, 'Cannot find .sdfcli.json')
    code = vim.fn.rename(new_json_path, old_json_path)
    assert(code, 'File was not changed back')

  end)

  it('checks if project directory is set', function()
    local old_path = config.opts.project_dir
    config.opts.project_dir = nil
    assert.has_error(function () config.set_environment() end, 'Project directory not set')
    config.opts.project_dir = old_path
  end)

  it('updates the environment related settings', function()
    vim.ui.select = function(_, _, cb) cb('Production') end
    local env = 'test'
    config.opts.environment_name = env
    assert.is_true(config.set_environment())
    assert.is_not.equals(env, config.opts.environment_name)
    assert.equal('Production', config.opts.environment_name)
  end)
end)

describe('The show_info function', function()

  it('should create a new window', function()
    spy.on(utils, 'create_win')
    config.show_info()
    assert.spy(utils.create_win).was_called()
  end)

  it('should write to the window', function()
    spy.on(utils, 'write_to_win')
    config.show_info()
    assert.spy(utils.write_to_win).was_called()
  end)

end)
