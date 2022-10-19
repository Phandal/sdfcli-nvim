local utils = require('sdfcli-nvim.utils')

describe('The file exists function', function()

  it('should return false if file does not exist', function()
    local path = "/some/path/that/does/not exist"
    assert.equal(utils.file_exists(path), false)
  end)

  it('should return true if file does exist', function()
    --local path = '/Users/bailey/Development/sdfcli-nvim/tests/sdfcli_utils_spec.lua'
    local path = '/'
    assert.equal(utils.file_exists(path), true)
  end)

end)

describe('the create_win function', function()

  it('should return a window and buffer handle', function()
    local win, buf = utils.create_win(10, 10);
    assert.is_not_nil(win)
    assert.is_not_nil(buf)
  end)

end)
