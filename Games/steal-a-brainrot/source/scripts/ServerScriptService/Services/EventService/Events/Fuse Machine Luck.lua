local FuseMachineLuck = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local NotificationService = require(ServerScriptService.Services.NotificationService)

local function SetLuckForAll(value)
	for _, player in ipairs(Players:GetPlayers()) do
		local data = Synchronizer:Get(player)
		if data then
			data:Set("FuseMachine.FuseLuckMultiplier", value)
		end
	end
end

function FuseMachineLuck.OnStart()
	ReplicatedStorage:SetAttribute("FuseMachineLuck", 5)
	SetLuckForAll(5)
	for _, player in game:GetService("Players"):GetPlayers() do
		NotificationService.Notify(player, "Admin activated <font color='#FFD13B'>Fuse Machine Luck</font>!", 10, "Sounds.Sfx.Success")
	end
end

function FuseMachineLuck.OnStop()
	ReplicatedStorage:SetAttribute("FuseMachineLuck", 1)
	SetLuckForAll(1)
end

return FuseMachineLuck