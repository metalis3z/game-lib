--!strict

local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local CommandsPage = require(frontend.Pages.CommandsPage)

return CommandsPage
