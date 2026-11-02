local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Bootstrap = require(ServerScriptService.Modules.Bootstrap)
Bootstrap(ServerScriptService.Controllers)

local PlayerController = require(ServerScriptService.Controllers.PlayerController)
local SpeedRunController = require(ServerScriptService.Controllers.SpeedRunController)

SpeedRunController:SetupSharedInstances()
SpeedRunController:Start()

game:BindToClose(function()
	if PlayerController.isShuttingDown then return end
	PlayerController.isShuttingDown = true
	task.wait(3)
end)