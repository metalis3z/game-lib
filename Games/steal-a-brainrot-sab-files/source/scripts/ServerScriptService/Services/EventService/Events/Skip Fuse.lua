--!native
local skip = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local EventService = require(ServerScriptService.Services.EventService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local FuseMachineService = require(ServerScriptService.Services.FuseMachineService)

function skip.OnStart()
	local currentTime = workspace:GetServerTimeNow()

	local FuseMachine = workspace:FindFirstChild("FuseMachine")
	local FuseType = FuseMachine and FuseMachine:GetAttribute("FuseType") or "Normal"
	local MachineColor = "#00BFFF"

	if FuseType == "Normal" then
		MachineColor = "#00BFFF"
	elseif FuseType == "Divine" then
		MachineColor = "#FFD700"
	elseif FuseType == "Witch" then
		MachineColor = "#9B30FF"
	elseif FuseType == "Santa" then
		MachineColor = "#FF0000"
	elseif FuseType == "Summer" then
		MachineColor = "#e1bb62"
	end

	for _, player in Players:GetPlayers() do
		local data = Synchronizer:Get(player)

		if data then
			local fuseData = data:Get("FuseMachine")

			if fuseData and (fuseData.StartTime and fuseData.StartTime > 0) and (fuseData.FinishTime and fuseData.FinishTime > currentTime) then

				data:Set("FuseMachine.FinishTime", currentTime - 1)

				local message = string.format("Sammy skipped your <font color=\"%s\">fuse timer</font>!", MachineColor)
				NotificationService.Notify(player, message, 5, "Sounds.Sfx.Success")

				FuseMachineService:UpdateFuseMachineData(player)
			end
		end
	end

	EventService:CancelEvent(script.Name)
end

function skip.OnStop()
end

return skip