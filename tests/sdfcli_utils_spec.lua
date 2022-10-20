local utils = require('sdfcli-nvim.utils')

describe('The file exists function', function()

  it('should return false if file does not exist', function()
    local path = "/some/path/that/does/not exist"
    assert.equal(utils.file_exists(path), false)
  end)

  it('should return true if file does exist', function()
    local path = '/'
    assert.equal(utils.file_exists(path), true)
  end)

end)

describe('the create_win function', function()

  it('should return a valid window and buffer handle', function()
    local win, bufnr = utils.create_win();
    assert.is_not_nil(win)
    assert.is_not_nil(bufnr)
    assert.is_true(vim.api.nvim_win_is_valid(win))
    assert.is_true(vim.api.nvim_buf_is_valid(bufnr))
  end)

  it('should check if there is already a window open', function()
    spy.on(vim.api, 'nvim_win_is_valid')
    utils.create_win()
    assert.spy(vim.api.nvim_win_is_valid).was_called()
  end)

end)

describe('the write_to_file function', function()

  it('should make sure modifiable is false', function()
    local _, bufnr = utils.create_win();
    assert.is_false(vim.api.nvim_buf_get_option(bufnr, 'modifiable'));
  end)

end)
