local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkModule = require(ReplicatedStorage.Packages.Net)

if not RunService:IsServer() then
	return NetworkModule:Invoke("BrainrotToTrade/RequestList")
end

local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local BrainrotTraderData =
	require(ServerStorage.Modules.BrainrotTraderData)

local CommandsService =
	require(ServerScriptService.Services.CommandsService)

local TradeBrainrotNameList = {}

for _, GroupData in BrainrotTraderData.Groups do
	for _, BrainrotData in GroupData.Brainrots do
		local BrainrotName = BrainrotData.Name
		table.insert(TradeBrainrotNameList, BrainrotName)
	end
end

NetworkModule:Handle("BrainrotToTrade/RequestList", function(Player)
	local PlayerRole = CommandsService:GetRoleAsync(Player)

	if PlayerRole ~= "Dev" and PlayerRole ~= "Lead" then
		return {}
	end

	return TradeBrainrotNameList
end)

return TradeBrainrotNameList