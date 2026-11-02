--!native
local skip = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local EventService = require(ServerScriptService.Services.EventService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)

function skip.OnStart()
	local currentTime = workspace:GetServerTimeNow()

	for _, player in Players:GetPlayers() do
		local data = Synchronizer:Get(player)

		if data then
			local craftingData = data:Get("CraftingMachine")

			if craftingData and (craftingData.StartTime and craftingData.StartTime > 0) and (craftingData.FinishTime and craftingData.FinishTime > currentTime) then

				data:Set("CraftingMachine.FinishTime", currentTime - 1)

				local message = 'Sammy skipped your <font color="#79dbff">craft timer</font>!'
				NotificationService.Notify(player, message, 5, "Sounds.Sfx.Success")
			end
		end
	end

	EventService:CancelEvent(script.Name)
end

function skip.OnStop()
end

return skip