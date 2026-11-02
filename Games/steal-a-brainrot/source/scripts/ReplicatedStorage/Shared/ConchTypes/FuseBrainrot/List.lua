local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetworkModule = require(ReplicatedStorage.Packages.Net)

if not RunService:IsServer() then
	return NetworkModule:Invoke("FuseBrainrot/RequestList")
end

local ServerScriptService = game:GetService("ServerScriptService")

local ServerFuseMachineData =
	require(ServerScriptService.Services.FuseMachineService.ServerFuseMachineData)

local CommandsService =
	require(ServerScriptService.Services.CommandsService)

local BrainrotOutputList = {}

for BrainrotName in ServerFuseMachineData.BrainrotOutputs do
	table.insert(BrainrotOutputList, BrainrotName)
end

NetworkModule:Handle("FuseBrainrot/RequestList", function(Player)
	local PlayerRole = CommandsService:GetRoleAsync(Player)

	if PlayerRole ~= "Dev" and PlayerRole ~= "Lead" then
		return {}
	end

	return BrainrotOutputList
end)

return BrainrotOutputList