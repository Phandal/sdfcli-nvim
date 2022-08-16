-- Create an object for the module. All the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules
M.setup = require('sdfcli-nvim.config').setup
M.create_project = require('sdfcli-nvim.commands.create_project').create_project
M.deploy_project = require('sdfcli-nvim.commands.deploy_project').deploy_project
M.switch_environments = require('sdfcli-nvim.config').set_environment

return M
