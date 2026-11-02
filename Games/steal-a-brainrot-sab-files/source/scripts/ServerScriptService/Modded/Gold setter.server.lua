local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GoldServiceLogic = require(ServerScriptService.Services.CmdrService.Commands.CustomCommands.addgoldServer) 

local net = require(ReplicatedStorage.Packages.Net)
local goldRemote = net:RemoteFunction("AdminService/GiveGold")

goldRemote.OnServerInvoke = function(player, amount, isAdd)
	local targetPlayers = {player}

	local resultMessage = GoldServiceLogic(nil, targetPlayers, amount, isAdd)

	if string.find(resultMessage, "💰") or string.find(resultMessage, "✅") then
		return true, resultMessage
	else
		return false, resultMessage
	end
end