-- Imports the plugin's additional Lua modules
local sdf_commands = require("sdfcli-nvim.sdf_commands")
local config = require("sdfcli-nvim.config")

-- Create an object for the module. All the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules
M.create_project = sdf_commands.create_project
M.setup = config.setup

return M
